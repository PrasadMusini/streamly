import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Dio _dio;
  static const String _isLoggedInKey = 'is_logged_in';

  AuthRepository(this._dio);

  Future<void> login(
    BuildContext context, {
    required String username,
    required String password,
    required String? deviceToken,
    bool isActive = true,
  }) async {
    try {
      final reqbody = {
        'username': username,
        'password': password,
        'deviceToken': deviceToken,
        'isActive': isActive,
      };

      print('reqbody: $reqbody');
      final response = await _dio.post(
        'http://localhost:4000/api/users/login',
        // '/api/users/login',
        data: reqbody,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login successful')));
        await saveLoginState(true);
        return;
      }
      throw Exception('Login failed with status code: ${response.statusCode}');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong')));
      rethrow;
    }
  }

  @Deprecated('Use login() method instead')
  Future<void> sendFcmToken(BuildContext context, String fcmToken) async {
    try {
      final response = await _dio.post(
        '/api/users/login',
        data: {'fcmToken': fcmToken},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login successful')));
        await saveLoginState(true);
      }
      throw Exception('Failed to send FCM token');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> logout() async {
    await saveLoginState(false);
  }
}
