// ignore_for_file: library_private_types_in_public_api

import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:desafio_target/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:desafio_target/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:desafio_target/features/notes/domain/usecases/edit_note_usecase.dart';
import 'package:desafio_target/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:mobx/mobx.dart';

part 'note_controller.g.dart';

class NoteController = _NoteController with _$NoteController;

abstract class _NoteController with Store {
  final GetNotesUseCase _getNotes;
  final AddNoteUseCase _addNote;
  final EditNoteUseCase _editNote;
  final DeleteNoteUseCase _deleteNote;

  _NoteController(this._getNotes, this._addNote, this._editNote, this._deleteNote);

  @observable
  ObservableList<NoteModel> notes = ObservableList();

  @observable
  String? errorMessage;

  @observable
  bool isLoading = false;

  @action
  Future<void> loadNotes() async {
    errorMessage = null;
    isLoading = true;

    final result = await _getNotes();

    if (result is Failure<List<NoteModel>>) {
      errorMessage = result.error.message;
      isLoading = false;
      return;
    }

    notes = ObservableList.of((result as Success<List<NoteModel>>).data);
    isLoading = false;
  }

  @action
  Future<void> addNote(String? title, String content) async {
    final note = NoteModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
    );

    final result = await _addNote(note);
    if (result is Failure) {
      errorMessage = result.error.message;
      return;
    }

    notes.add(note);
  }

  @action
  Future<void> editNote(NoteModel note, String? title, String content) async {
    final updated = NoteModel(id: note.id, title: title, content: content, createdAt: note.createdAt);

    final result = await _editNote(updated);
    if (result is Failure) {
      errorMessage = result.error.message;
      return;
    }

    final index = notes.indexWhere((n) => n.id == note.id);
    if (index != -1) notes[index] = updated;
  }

  @action
  Future<void> deleteNote(String id) async {
    final result = await _deleteNote(id);

    if (result is Failure) {
      errorMessage = result.error.message;
      return;
    }

    notes.removeWhere((n) => n.id == id);
  }
}
