<<<<<<< HEAD
class Task {
  final String taskId;
  final String taskName;
  final String dateOfUpload;
  final String timeOfUpload;
  final int uploadMilliSecond;

  Task(
      {required this.taskId,
      required this.taskName,
      required this.dateOfUpload,
      required this.timeOfUpload,
      required this.uploadMilliSecond});
}
=======
class Tasks {
  final String taskId;
  final String taskName;
  final String dateOfUpload;
  final String timeOfUpload;
  final int uploadMilliSecond;

  Tasks({
    required this.taskId,
    required this.taskName,
    required this.dateOfUpload,
    required this.timeOfUpload,
    required this.uploadMilliSecond,
  });

  // Convert a Task object into a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'taskName': taskName,
      'dateOfUpload': dateOfUpload,
      'timeOfUpload': timeOfUpload,
      'uploadMilliSecond': uploadMilliSecond,
    };
  }

  // Create a Task object from a Firestore document
  factory Tasks.fromMap(Map<String, dynamic> map) {
    return Tasks(
      taskId: map['taskId'],
      taskName: map['taskName'],
      dateOfUpload: map['dateOfUpload'],
      timeOfUpload: map['timeOfUpload'],
      uploadMilliSecond: map['uploadMilliSecond'],
    );
  }
}
>>>>>>> b42ce23 (Intial Commit)
