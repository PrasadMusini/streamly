import 'package:flutter/material.dart';
import 'package:streamly_cresolinfoserv/core/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget buildOption({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Profile Avatar
            CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.primary,
              child: const Text(
                "P",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// User Name
            const Text(
              "Prasad",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 15),

            const Divider(),

            buildOption(
              icon: Icons.settings,
              title: "Change Controllers",
              onTap: () {},
            ),

            buildOption(icon: Icons.palette, title: "Appearance", onTap: () {}),

            buildOption(icon: Icons.language, title: "Languages", onTap: () {}),

            buildOption(
              icon: Icons.privacy_tip,
              title: "Privacy Policy",
              onTap: () {},
            ),

            buildOption(icon: Icons.logout, title: "Logout", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
