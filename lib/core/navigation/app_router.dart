import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const stats = '/stats';

  static final router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        builder: (_, _) => const Scaffold(body: Center(child: Text('Login'))),
      ),
      GoRoute(
        path: signup,
        builder: (_, _) => const Scaffold(body: Center(child: Text('Criar conta'))),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (_, _) => const Scaffold(body: Center(child: Text('Esqueci a senha'))),
      ),
      GoRoute(
        path: home,
        builder: (_, _) => const Scaffold(body: Center(child: Text('Home'))),
      ),
      GoRoute(
        path: stats,
        builder: (_, _) => const Scaffold(body: Center(child: Text('Estatísticas'))),
      ),
    ],
  );
}
