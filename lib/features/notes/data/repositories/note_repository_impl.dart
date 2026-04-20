import 'package:desafio_target/core/error/error_handler.dart';
import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/notes/data/datasources/note_local_datasource.dart';
import 'package:desafio_target/features/notes/data/datasources/note_remote_datasource.dart';
import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:desafio_target/features/notes/domain/repositories/note_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource _local;
  final NoteRemoteDataSource _remote;
  final FirebaseAuth _auth;

  NoteRepositoryImpl(this._local, this._remote, this._auth);

  String? get _uid => _auth.currentUser?.uid;

  @override
  Future<Result<List<NoteModel>>> getNotes() async {
    try {
      final uid = _uid;

      if (uid != null) {
        final notes = await _remote.getNotes(uid);
        return Success(notes);
      }

      return Success(_local.getNotes());
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<void>> addNote(NoteModel note) async {
    try {
      final uid = _uid;

      if (uid != null) {
        await _remote.addNote(uid, note);
        return const Success(null);
      }

      await _local.addNote(note);
      return const Success(null);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<void>> editNote(NoteModel note) async {
    try {
      final uid = _uid;

      if (uid != null) {
        await _remote.editNote(uid, note);
        return const Success(null);
      }

      await _local.editNote(note);
      return const Success(null);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<void>> deleteNote(String id) async {
    try {
      final uid = _uid;

      if (uid != null) {
        await _remote.deleteNote(uid, id);
        return const Success(null);
      }

      await _local.deleteNote(id);
      return const Success(null);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Result<void>> migrateLocalNotes(String uid) async {
    try {
      final localNotes = _local.getNotes();

      for (final note in localNotes) {
        await _remote.addNote(uid, note);
      }

      await _local.clearAll();
      return const Success(null);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }
}
