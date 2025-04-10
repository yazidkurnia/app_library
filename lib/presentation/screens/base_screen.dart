// lib/core/presentation/base_page.dart
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final String title;
  final Widget body;
  final List<BottomNavigationBarItem>? bottomNavItems;
  final int? currentIndex;
  final Function(int)? onNavItemTapped;
  final List<Widget>? actions;
  final bool showBackButton;

  const BasePage({
    Key? key,
    required this.title,
    required this.body,
    this.bottomNavItems,
    this.currentIndex,
    this.onNavItemTapped,
    this.actions,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget? _buildBottomNav() {
    if (bottomNavItems == null) return null;

    return BottomNavigationBar(
      items: bottomNavItems!,
      currentIndex: currentIndex!,
      onTap: onNavItemTapped!,
      selectedItemColor: Colors.blue, // Aktif
      unselectedItemColor:
          const Color.fromARGB(255, 179, 179, 179), // Tidak aktif
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}
