<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/models/task.dart'; // Ensure this file exists and has the updated Task model

class TaskService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Add a new task to the database
  Future<void> addTask(Task task) async {
    try {
      await _firebaseFirestore.collection("Tasks").doc(task.taskId).set({
        "taskId": task.taskId,
        "taskName": task.taskName,
        "dateOfUpload": task.dateOfUpload,
        "timeOfUpload": task.timeOfUpload,
        "uploadMilliSecond": task.uploadMilliSecond,
      });
    } catch (e) {
      print("Error adding task: ${e.toString()}");
    }
  }

  // Get a single task by its ID
  Future<Task?> getTask(String taskId) async {
    try {
      DocumentSnapshot doc = await _firebaseFirestore.collection("Tasks").doc(taskId).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Task(
          taskId: data["taskId"],
          taskName: data["taskName"],
          dateOfUpload: data["dateOfUpload"],
          timeOfUpload: data["timeOfUpload"],
          uploadMilliSecond: data["uploadMilliSecond"],
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching task: ${e.toString()}");
      return null;
    }
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    try {
      await _firebaseFirestore.collection("Tasks").doc(task.taskId).update({
        "taskName": task.taskName,
        "dateOfUpload": task.dateOfUpload,
        "timeOfUpload": task.timeOfUpload,
        "uploadMilliSecond": task.uploadMilliSecond,
      });
    } catch (e) {
      print("Error updating task: ${e.toString()}");
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      await _firebaseFirestore.collection("Tasks").doc(taskId).delete();
    } catch (e) {
      print("Error deleting task: ${e.toString()}");
    }
  }

  // Get all tasks
  Future<List<Task>> getAllTasks() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection("Tasks").get();
      List<Task> tasks = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        tasks.add(Task(
          taskId: data["taskId"],
          taskName: data["taskName"],
          dateOfUpload: data["dateOfUpload"],
          timeOfUpload: data["timeOfUpload"],
          uploadMilliSecond: data["uploadMilliSecond"],
        ));
      }
      return tasks;
    } catch (e) {
      print("Error fetching tasks: ${e.toString()}");
      return [];
    }
  }
}
=======
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
>>>>>>> b42ce23 (Intial Commit)
