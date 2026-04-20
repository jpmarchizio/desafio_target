import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:desafio_target/shared/widgets/app_button.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:desafio_target/shared/widgets/app_text_field.dart';
import 'package:desafio_target/shared/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';

class NoteDialog extends StatefulWidget {
  final NoteModel? note;
  final void Function(String? title, String content) onSave;
  final VoidCallback? onDelete;

  const NoteDialog({
    super.key,
    this.note,
    required this.onSave,
    this.onDelete,
  });

  static void show(
    BuildContext context, {
    NoteModel? note,
    required void Function(String? title, String content) onSave,
    VoidCallback? onDelete,
  }) {
    showDialog(
      context: context,
      builder: (_) => NoteDialog(
        note: note,
        onSave: onSave,
        onDelete: onDelete,
      ),
    );
  }

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.note != null;

  void _save() {
    final content = _contentController.text.trim();
    if (content.isEmpty) return;

    final title = _titleController.text.trim();
    widget.onSave(title.isEmpty ? null : title, content);
    Navigator.of(context).pop();
  }

  void _delete() {
    ConfirmDialog.show(
      context,
      title: 'Confirmar exclusão',
      message: 'Deseja excluir esta nota?',
      confirmLabel: 'Excluir',
      onConfirm: () {
        Navigator.of(context).pop();
        widget.onDelete?.call();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;

    return Dialog(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText.title(_isEditing ? 'Editar nota' : 'Nova nota'),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, size: 20),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppTextField(
              label: 'Título',
              hint: 'Título da nota',
              controller: _titleController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Conteúdo',
              hint: 'Escreva sua nota...',
              controller: _contentController,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Salvar',
              onPressed: _save,
            ),
            if (_isEditing) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: AppButton.outlined(
                  label: 'Excluir nota',
                  onPressed: _delete,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
