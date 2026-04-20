import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/notes/domain/repositories/note_repository.dart';

class DeleteNoteUseCase {
  final NoteRepository _repository;

  DeleteNoteUseCase(this._repository);

  Future<Result<void>> call(String id) => _repository.deleteNote(id);
}
