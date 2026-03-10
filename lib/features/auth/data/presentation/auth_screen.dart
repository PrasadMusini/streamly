import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';
import 'package:streamly_cresolinfoserv/features/auth/data/repositories/auth_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:streamly_cresolinfoserv/navigation/app_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository(Dio());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    // Validate form fields
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("_handleLogin: FCM Token = $fcmToken");

    try {
      await _authRepository.login(
        context,
        username: username,
        password: password,
        deviceToken: fcmToken,
        isActive: true,
      );
      if (mounted) {
        context.go(Routes.screenHome.path);
      }
    } catch (e) {
      print('Login error: $e');
      rethrow;
      // Error is already handled in the repository (SnackBar)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0040A0), Color(0xFF001D4A)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.movie_filter_rounded,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Streamly",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 48),
                    _buildTextField(
                      controller: _usernameController,
                      hintText: "Username",
                      icon: Icons.person_outline,
                      validator: _validateUsername,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      icon: Icons.lock_outline,
                      isPassword: true,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: _buildButton(
                            label: "Login",
                            onPressed: _handleLogin,
                            isPrimary: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildButton(
                            label: "Guest",
                            onPressed: _handleLogin,
                            isPrimary: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? Colors.white
            : Colors.white.withOpacity(0.1),
        foregroundColor: isPrimary ? const Color(0xFF0040A0) : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isPrimary
              ? BorderSide.none
              : BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        elevation: isPrimary ? 8 : 0,
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
