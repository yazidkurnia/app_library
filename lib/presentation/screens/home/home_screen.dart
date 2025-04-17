import 'package:app_library/presentation/screens/base_screen.dart';
import 'package:app_library/presentation/screens/home/partial/content.dart';
import 'package:flutter/material.dart';

import '../../../data/data_sources/localstorage/shared_preferences_service.dart';
import '../approvals/loaning/loan_screen.dart';
import '../profile/profile_screen.dart';
import '../transaction/transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchBookController = TextEditingController();
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  String? userRole;
  int _currentIndex = 0;

  List<BottomNavigationBarItem> get _navItems {
    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.receipt_long),
        label: 'Transaction',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];

    if (userRole == '1') {
      items.insert(
          1,
          const BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ));
    }

    return items;
  }

  Future<void> _loadUserRole() async {
    final role = await sharedPreferencesService.getUserRole();
    setState(() {
      userRole = role;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  @override
  void dispose() {
    super.dispose();
    _searchBookController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBody() {
      // Return different content based on _currentIndex
      switch (_currentIndex) {
        case 0:
          return const Center(child: Content());
        case 1:
          return const LoanScreen();
        case 2:
          return const Center(child: TransactionScreen());
        default:
          return const Center(child: ProfileScreen());
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
