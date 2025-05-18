// note_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/note.dart';

class NoteService {
  final CollectionReference _noteCollection =
      FirebaseFirestore.instance.collection('notes');

  Stream<List<Note>> getNotes() {
    return _noteCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Note(
          id: doc.id,
          content: doc['content'],
        );
      }).toList();
    });
  }

  Future<void> addNote(Note note) {
    return _noteCollection.add({
      'content': note.content,
    });
  }

  Future<void> deleteNote(String id) {
    return _noteCollection.doc(id).delete();
  }
}
