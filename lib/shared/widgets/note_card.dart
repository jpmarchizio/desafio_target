import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:desafio_target/shared/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final String displayTitle;
  final bool hasTitle;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NoteCard({
    super.key,
    required this.note,
    required this.displayTitle,
    required this.hasTitle,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final border = isDark ? AppColors.borderDark : AppColors.borderLight;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: surface,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hasTitle
                      ? AppText.title(displayTitle, maxLines: 1, overflow: TextOverflow.ellipsis)
                      : AppText.body(displayTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (hasTitle) ...[
                    const SizedBox(height: 4),
                    AppText.body(
                      note.content,
                      color: textSecondary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onTap,
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                ),
                IconButton(
                  onPressed: () => ConfirmDialog.show(
                    context,
                    onConfirm: onDelete,
                  ),
                  icon: Icon(Icons.delete_outline, size: 20, color: AppColors.error),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
