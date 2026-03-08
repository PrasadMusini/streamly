import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:streamly_cresolinfoserv/core/styles/colors.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Theme.of(context).colorScheme.outline,
        ),
        child: Material(
          color: Colors.white,
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            elevation: 21,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 8,
            selectedFontSize: 12,
            showSelectedLabels: false,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            items: <BottomNavigationBarItem>[
              buildBottomNavItem(
                context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
              ),
              buildBottomNavItem(
                context,
                icon: Icons.person_2_outlined,
                activeIcon: Icons.person_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 30, color: Colors.black),
      activeIcon: Icon(activeIcon, size: 32, color: AppColors.primary),
      label: 'Home',
    );
  }
}
