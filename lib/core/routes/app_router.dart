import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_routes.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  /// Instance GoRouter untuk seluruh aplikasi
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    debugLogDiagnostics: true,
    routes: [
      // Menggabungkan semua rute dari berbagai modul
      ...HomeRoutes.routes,
      // ...AuthRoutes.routes,
      // ...ProfileRoutes.routes,
      // ...SettingsRoutes.routes,
    ],
    // Handler untuk rute yang tidak ditemukan
    // errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
