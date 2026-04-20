import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/notes/domain/models/note_model.dart';

abstract interface class NoteRepository {
  Future<Result<List<NoteModel>>> getNotes();
  Future<Result<void>> addNote(NoteModel note);
  Future<Result<void>> editNote(NoteModel note);
  Future<Result<void>> deleteNote(String id);
  Future<Result<void>> migrateLocalNotes(String uid);
}
