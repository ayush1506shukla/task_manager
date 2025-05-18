import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/task.dart'; // Ensure this is the correct path to the task model

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to generate a unique task ID
  String generateTaskId() {
    return _db.collection('tasks').doc().id;
  }

  Stream<List<Tasks>> getTasks() {
    return _db.collection('tasks').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Tasks.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }
  Future<void> deleteTask(String taskId) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
      // Optionally handle success or show a message
    } catch (e) {
      // Handle any errors
      print(e);
    }
  }
   Future<void> updateTask(String taskId, String taskName, String taskDate, String taskTime) async {
    await _db.collection('tasks').doc(taskId).update({
      'taskName': taskName,
      'dateOfUpload': taskDate,
      'timeOfUpload': taskTime,
    });
  }

  // Method to add a task to Firestore
  Future<void> addTask(Tasks task) async {
    await _db.collection('tasks').doc(task.taskId).set(task.toMap());
  }

  // You can add methods for fetching, updating, and deleting tasks if needed
  
}
