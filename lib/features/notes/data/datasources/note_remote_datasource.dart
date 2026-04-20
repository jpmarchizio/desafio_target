import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_target/features/notes/domain/models/note_model.dart';

class NoteRemoteDataSource {
  final FirebaseFirestore _firestore;

  NoteRemoteDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> _collection(String uid) =>
      _firestore.collection('users').doc(uid).collection('notes');

  Future<List<NoteModel>> getNotes(String uid) async {
    final snapshot = await _collection(uid)
        .orderBy('createdAt', descending: true)
        .get()
        .timeout(const Duration(seconds: 10));

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return NoteModel(
        id: doc.id,
        title: data['title'] as String?,
        content: data['content'] as String,
        createdAt: (data['createdAt'] as Timestamp).toDate(),
      );
    }).toList();
  }

  Future<void> addNote(String uid, NoteModel note) =>
      _collection(uid).doc(note.id).set({
        'title': note.title,
        'content': note.content,
        'createdAt': Timestamp.fromDate(note.createdAt),
      });

  Future<void> editNote(String uid, NoteModel note) =>
      _collection(uid).doc(note.id).update({
        'title': note.title,
        'content': note.content,
      });

  Future<void> deleteNote(String uid, String id) => _collection(uid).doc(id).delete();
}
