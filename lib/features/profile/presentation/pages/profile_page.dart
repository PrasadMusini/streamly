import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.person), title: Text("Edit Profile")),

          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),

          ListTile(leading: Icon(Icons.settings), title: Text("Settings")),

          ListTile(leading: Icon(Icons.logout), title: Text("Logout")),
        ],
      ),
    );
  }
}
