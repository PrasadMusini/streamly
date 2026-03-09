import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:streamly_cresolinfoserv/core/styles/colors.dart';

class FloatingNavigationBarItem {
  final IconData icon;
  final IconData? unselectedIcon;
  final Badge? badge;
  final Color? selectedColor;
  final Color? unselectedColor;
  final String? title;

  FloatingNavigationBarItem({
    required this.icon,
    this.unselectedIcon,
    this.selectedColor,
    this.unselectedColor,
    this.badge,
    this.title,
  });
}

class FloatingNavigationBar extends StatelessWidget {
  const FloatingNavigationBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.height = 60,
    this.borderRadius = 40,
    this.backgroundColor = const Color(0xFFf9f9f9),
    this.horizontalMargin = 50,
    this.blurSigma = 12,
    this.selectedPillColor = const Color(0xffe6e6e6),
    this.selectedIconColor = AppColors.navBarSelectedIconColor,
    this.unselectedIconColor = const Color(0xFF313131),
    this.barItemSize = 2,
    this.labelStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  });

  final List<FloatingNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final double height;
  final double borderRadius;
  final double horizontalMargin;
  final Color backgroundColor;
  final double blurSigma;
  final Color selectedPillColor;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final TextStyle labelStyle;
  final int barItemSize;

  @override
  Widget build(BuildContext context) {
    final visible = items.take(barItemSize).toList();

    return Padding(
      padding: EdgeInsets.only(
        left: horizontalMargin,
        right: horizontalMargin,
        bottom: !Platform.isIOS ? 8 : 18,
      ),
      child: SafeArea(
        bottom: !Platform.isIOS,
        child: SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Colors.black12, width: 0.6),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: visible.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final item = entry.value;
                    final isSelected = idx == currentIndex;

                    return Expanded(
                      child: _NavItem(
                        item: item,
                        isSelected: isSelected,
                        selectedPillColor: selectedPillColor,
                        selectedIconColor: selectedIconColor,
                        unselectedIconColor: unselectedIconColor,
                        labelStyle: labelStyle,
                        onTap: () => onTap?.call(idx),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.selectedPillColor,
    required this.selectedIconColor,
    required this.unselectedIconColor,
    required this.labelStyle,
    required this.onTap,
  });

  final FloatingNavigationBarItem item;
  final bool isSelected;
  final Color selectedPillColor;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final TextStyle labelStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon = isSelected ? item.icon : (item.unselectedIcon ?? item.icon);
    final iconColor = isSelected ? selectedIconColor : unselectedIconColor;
    final labelColor = isSelected ? selectedIconColor : unselectedIconColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: isSelected
            ? BoxDecoration(
                color: selectedPillColor,
                borderRadius: BorderRadius.circular(30),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.25 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuint,
              child: Icon(icon, size: 24, color: iconColor),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                item.title ?? '',
                style: labelStyle.copyWith(color: labelColor, fontSize: 11),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
