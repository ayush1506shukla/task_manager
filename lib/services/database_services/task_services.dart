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
