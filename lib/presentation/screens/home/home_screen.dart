import 'package:app_library/presentation/screens/base_screen.dart';
import 'package:app_library/presentation/screens/home/partial/content.dart';
import 'package:flutter/material.dart';

import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchBookController = TextEditingController();

  int _currentIndex = 0;

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  void dispose() {
    super.dispose();
    _searchBookController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildSearchBookField() {
      return Expanded(
          child: TextField(
        controller: _searchBookController,
      ));
    }

    Widget _buildBody() {
      // Return different content based on _currentIndex
      switch (_currentIndex) {
        case 0:
          return const Center(child: Content());
        case 1:
          return const Center(child: Text('Business Content'));
        case 2:
          return const Center(child: ProfileScreen());
        default:
          return const SizedBox.shrink();
      }
    }

    return BasePage(
      title: 'Home',
      body: _buildBody(),
      bottomNavItems: _navItems,
      currentIndex: _currentIndex,
      onNavItemTapped: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Handle notification action
          },
        ),
      ],
    );
  }
}
