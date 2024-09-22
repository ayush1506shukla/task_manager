import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final Function(Map<String, String>) onTaskAdded;

  AddTaskScreen({required this.onTaskAdded});

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDateController = TextEditingController();
  final TextEditingController _taskTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskNameController,
              decoration: InputDecoration(labelText: "Task Name"),
            ),
            TextField(
              controller: _taskDateController,
              decoration: InputDecoration(labelText: "Task Date"),
            ),
            TextField(
              controller: _taskTimeController,
              decoration: InputDecoration(labelText: "Task Time"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // When the "Add Task" button is pressed, create the task map and pass it back
                Map<String, String> newTask = {
                  'taskName': _taskNameController.text,
                  'taskDate': _taskDateController.text,
                  'taskTime': _taskTimeController.text,
                };
                onTaskAdded(newTask);
                Navigator.pop(context);
              },
              child: Text("Add Task"),
            )
          ],
        ),
      ),
    );
  }
}
