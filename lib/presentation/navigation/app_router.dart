// lib/presentation/navigation/app_router.dart

import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/list/asteroid_list_screen.dart';
import '../screens/detail/asteroid_detail_screen.dart';
import '../screens/favorites/favorites_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _slide(const HomeScreen());
      case '/list':
        return _slide(const AsteroidListScreen());
      case '/detail':
        return _slide(const AsteroidDetailScreen());
      case '/favorites':
        return _slide(const FavoritesScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }

  static PageRouteBuilder _slide(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, animation, __) => page,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
