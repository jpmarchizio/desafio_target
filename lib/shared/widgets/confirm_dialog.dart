import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ConfirmDialog {
  ConfirmDialog._();

  static void show(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const AppText.title('Confirmar exclusão'),
        content: const AppText.body('Deseja excluir esta nota?'),
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
            child: AppText.button('Excluir', color: AppColors.error),
          ),
        ],
      ),
    );
  }
}
