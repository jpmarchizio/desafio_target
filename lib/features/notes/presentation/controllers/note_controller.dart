// ignore_for_file: library_private_types_in_public_api

import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:mobx/mobx.dart';

part 'note_controller.g.dart';

class NoteController = _NoteController with _$NoteController;

abstract class _NoteController with Store {
  @observable
  ObservableList<NoteModel> notes = ObservableList();

  @action
  void addNote(String? title, String content) {
    notes.add(NoteModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
    ));
  }

  @action
  void editNote(NoteModel note, String? title, String content) {
    final index = notes.indexWhere((n) => n.id == note.id);
    if (index == -1) return;

    notes[index] = NoteModel(
      id: note.id,
      title: title,
      content: content,
      createdAt: note.createdAt,
    );
  }

  @action
  void deleteNote(String id) {
    notes.removeWhere((n) => n.id == id);
  }
}
