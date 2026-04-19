import 'package:desafio_target/core/navigation/app_router.dart';
import 'package:desafio_target/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TargetToDoApp extends StatelessWidget {
  const TargetToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Target To-Do',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
