import 'package:flutter/material.dart';
import 'package:streamly_cresolinfoserv/core/styles/colors.dart';

/* class ProfileScreen extends StatelessWidget {
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
} */

//MARK: New Ui
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget buildOption({
    required IconData icon,
    required String title,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget sectionCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.redColor,
                    AppColors.redColor.withOpacity(.7),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  /// Avatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Text(
                        "x",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Name
                  const Text(
                    "Prasad",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "Flutter Developer",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// SETTINGS SECTION
            sectionCard([
              buildOption(
                icon: Icons.settings,
                title: "Change Controllers",
                iconColor: Colors.blue,
                onTap: () {},
              ),
              const Divider(height: 1),
              buildOption(
                icon: Icons.palette,
                title: "Appearance",
                iconColor: Colors.purple,
                onTap: () {},
              ),
              const Divider(height: 1),
              buildOption(
                icon: Icons.language,
                title: "Languages",
                iconColor: Colors.green,
                onTap: () {},
              ),
            ]),

            /// POLICY SECTION
            sectionCard([
              buildOption(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                iconColor: Colors.orange,
                onTap: () {},
              ),
            ]),

            /// LOGOUT BUTTON
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text("Logout", style: TextStyle(fontSize: 16)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
