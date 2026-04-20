import 'package:desafio_target/core/di/injector.dart';
import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:desafio_target/features/notes/presentation/controllers/note_controller.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:desafio_target/shared/widgets/note_card.dart';
import 'package:desafio_target/shared/widgets/note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NoteController _controller;

  final List<NoteModel> _notes = [
    NoteModel(id: '1', title: 'Reunião de equipe', content: 'Discutir os próximos sprints ', createdAt: DateTime.now()),
    NoteModel(id: '2', title: null, content: 'testando', createdAt: DateTime.now()),
    NoteModel(
      id: '3',
      title: 'Titulo extremamente longo para testar o layout',
      content: 'teste teste teste',
      createdAt: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = getIt<NoteController>();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(backgroundColor: background, elevation: 0, title: const AppText.headline('Notas')),
      body: _notes.isEmpty ? _emptyState() : _notesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NoteDialog.show(
          context,
          onSave: _controller.addNote,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _emptyState() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.note_outlined, size: 48, color: textSecondary),
          const SizedBox(height: 12),
          AppText.body('Nenhuma nota ainda.', color: textSecondary),
          const SizedBox(height: 4),
          AppText.bodySmall('Toque em + para criar sua primeira nota.', color: textSecondary),
        ],
      ),
    );
  }

  Widget _notesList() {
    return Observer(
      builder: (_) => ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: _notes.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, index) {
          final note = _notes[index];

          return NoteCard(
            note: note,
            displayTitle: note.displayTitle,
            hasTitle: note.title != null,
            onTap: () => NoteDialog.show(
              context,
              note: note,
              onSave: (title, content) => _controller.editNote(note, title, content),
              onDelete: () => _controller.deleteNote(note.id),
            ),
            onDelete: () => _controller.deleteNote(note.id),
          );
        },
      ),
    );
  }
}
