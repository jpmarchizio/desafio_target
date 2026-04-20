import 'package:desafio_target/core/di/injector.dart';
import 'package:desafio_target/core/navigation/app_router.dart';
import 'package:desafio_target/core/theme/app_colors.dart';
import 'package:desafio_target/features/notes/presentation/controllers/home_controller.dart';
import 'package:desafio_target/core/theme/theme_controller.dart';
import 'package:desafio_target/shared/widgets/app_text.dart';
import 'package:desafio_target/shared/widgets/confirm_dialog.dart';
import 'package:desafio_target/shared/widgets/note_card.dart';
import 'package:desafio_target/shared/widgets/note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<HomeController>();
    _controller.loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: const AppText.headline('Notas'),
        actions: [
          Observer(builder: (_) {
            final themeController = getIt<ThemeController>();
            return Row(
              children: [
                IconButton(
                  icon: Icon(themeController.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
                  tooltip: 'Alternar tema',
                  onPressed: themeController.toggleTheme,
                ),
                if (!_controller.isLoggedIn)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: () => context.push(AppRouter.signup),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        elevation: 0,
                      ),
                      child: const AppText.button('Criar conta'),
                    ),
                  ),
                if (_controller.isLoggedIn)
                  IconButton(
                    icon: const Icon(Icons.logout),
                    tooltip: 'Sair',
                    onPressed: () => ConfirmDialog.show(
                      context,
                      title: 'Sair da conta',
                      message: 'Deseja desconectar da sua conta?',
                      confirmLabel: 'Sair',
                      onConfirm: () async {
                        await _controller.logout();
                        if (context.mounted) context.go(AppRouter.login);
                      },
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: Observer(builder: (_) {
        if (_controller.isLoading) return const Center(child: CircularProgressIndicator());
        if (_controller.errorMessage != null) return _errorState(_controller.errorMessage!);
        return _controller.notes.isEmpty ? _emptyState() : _notesList();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NoteDialog.show(context, onSave: _controller.addNote),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _errorState(String message) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return RefreshIndicator(
      onRefresh: _controller.loadNotes,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cloud_off_outlined, size: 48, color: textSecondary),
                const SizedBox(height: 12),
                AppText.body(message, color: textSecondary),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: _controller.loadNotes,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Tentar novamente'),
                ),
              ],
            ),
          ),
        ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return RefreshIndicator(
      onRefresh: _controller.loadNotes,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: _controller.notes.length + 1,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, index) {
          if (index == _controller.notes.length) {
            return Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 8),
              child: Center(
                child: TextButton.icon(
                  onPressed: () => context.push(AppRouter.stats),
                  icon: Icon(Icons.bar_chart_outlined, color: textSecondary),
                  label: AppText.body('Ver estatísticas', color: textSecondary),
                ),
              ),
            );
          }

          final note = _controller.notes[index];

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
