import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:streamly_cresolinfoserv/navigation/floating_nav_bar.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: FloatingNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: [
          FloatingNavigationBarItem(
            icon: Icons.home_rounded,
            unselectedIcon: Icons.home_outlined,
            title: 'Home',
          ),
          FloatingNavigationBarItem(
            icon: Icons.person_rounded,
            unselectedIcon: Icons.person_2_outlined,
            title: 'Profile',
          ),
        ],
      ),
    );
  }
}
