import 'package:flutter/material.dart';

import '../../../core/constants/debug_log.dart';
import '../../../data/data_sources/localstorage/shared_preferences_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> checkToken() async {
    String? token = await SharedPreferencesService().getToken();
    DebugLog().printLog('Current token: ${token ?? "No token found"}', 'info');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          await checkToken();
          await SharedPreferencesService().removeToken();
          await checkToken();
        },
        child: const Text('logout'));
  }
}
