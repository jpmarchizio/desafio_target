import 'package:desafio_target/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:desafio_target/features/auth/presentation/pages/login_page.dart';
import 'package:desafio_target/features/auth/presentation/pages/signup_page.dart';
import 'package:desafio_target/core/di/injector.dart';
import 'package:desafio_target/features/notes/data/datasources/note_local_datasource.dart';
import 'package:desafio_target/features/notes/presentation/pages/home_page.dart';
import 'package:desafio_target/features/notes/presentation/pages/stats_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    redirect: (_, state) {
      if (state.matchedLocation != login) return null;
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.isAnonymous) return home;
      if (getIt<NoteLocalDataSource>().getNotes().isNotEmpty) return home;
      return null;
    },
    routes: [
      GoRoute(path: login, builder: (_, _) => const LoginPage()),
      GoRoute(path: signup, builder: (_, _) => const SignupPage()),
      GoRoute(path: forgotPassword, builder: (_, _) => const ForgotPasswordPage()),
      GoRoute(path: home, builder: (_, _) => const HomePage()),
      GoRoute(path: stats, builder: (_, _) => const StatsPage()),
    ],
  );
}
