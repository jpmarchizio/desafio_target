// ignore_for_file: library_private_types_in_public_api

import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:mobx/mobx.dart';

part 'note_controller.g.dart';

class NoteController = _NoteController with _$NoteController;

abstract class _NoteController with Store {
  @observable
  ObservableList<NoteModel> notes = ObservableList();

  @action
  void addNote(String? title, String content) {}

  @action
  void editNote(NoteModel note, String? title, String content) {}

  @action
  void deleteNote(String id) {}
}
