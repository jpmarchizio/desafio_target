import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:desafio_target/features/notes/domain/repositories/note_repository.dart';

class GetNotesUseCase {
  final NoteRepository _repository;

  GetNotesUseCase(this._repository);

  Future<Result<List<NoteModel>>> call() => _repository.getNotes();
}
