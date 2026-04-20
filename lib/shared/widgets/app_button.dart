import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });

  const AppButton.outlined({super.key, required this.label, required this.onPressed, this.isLoading = false})
    : isOutlined = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? AppColors.primaryDark : AppColors.primary;

    if (isOutlined) {
      return OutlinedButton(onPressed: isLoading ? null : onPressed, child: _child(primary));
    }

    return ElevatedButton(onPressed: isLoading ? null : onPressed, child: _child(Colors.white));
  }

  Widget _child(Color color) {
    if (isLoading) {
      return SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: color));
    }

    return AppText.button(label, color: color);
  }
}
