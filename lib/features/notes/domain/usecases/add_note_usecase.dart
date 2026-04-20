import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:desafio_target/features/notes/domain/repositories/note_repository.dart';

class AddNoteUseCase {
  final NoteRepository _repository;

  AddNoteUseCase(this._repository);

  Future<Result<void>> call(NoteModel note) => _repository.addNote(note);
}
