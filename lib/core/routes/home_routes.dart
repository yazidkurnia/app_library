import 'package:go_router/go_router.dart';

import '../../presentation/screens/home/home_screen.dart';

class HomeRoutes {
  // Konstanta path untuk fitur ini
  static const String home = '/';
  static const String detail = '/detail/:id';

  // Daftar rute untuk fitur Home
  static List<RouteBase> routes = [
    GoRoute(
      path: home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    // GoRoute(
    //   path: detail,
    //   name: 'detail',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id'] ?? '';
    //     return DetailScreen(id: id);
    //   },
    // ),
  ];
}
