import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteLocalDataSource {
  static const _boxName = 'notes';

  Box<NoteModel> get _box => Hive.box<NoteModel>(_boxName);

  static Future<void> init() async => await Hive.openBox<NoteModel>(_boxName);

  List<NoteModel> getNotes() => _box.values.toList();

  Future<void> addNote(NoteModel note) => _box.put(note.id, note);

  Future<void> editNote(NoteModel note) => _box.put(note.id, note);

  Future<void> deleteNote(String id) => _box.delete(id);

  Future<void> clearAll() => _box.clear();
}
