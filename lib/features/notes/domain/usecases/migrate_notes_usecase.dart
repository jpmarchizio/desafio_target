import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/notes/domain/repositories/note_repository.dart';

class MigrateNotesUseCase {
  final NoteRepository _repository;

  MigrateNotesUseCase(this._repository);

  Future<Result<void>> call(String uid) => _repository.migrateLocalNotes(uid);
}
