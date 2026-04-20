import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: CircularProgressIndicator(color: isDark ? AppColors.primaryDark : AppColors.primary, strokeWidth: 2.5),
    );
  }
}
