import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ConfirmDialog {
  ConfirmDialog._();

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required VoidCallback onConfirm,
    Color? confirmColor,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: AppText.title(title),
        content: AppText.body(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const AppText.button('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: AppText.button(confirmLabel, color: confirmColor ?? AppColors.error),
          ),
        ],
      ),
    );
  }
}
