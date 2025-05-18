<<<<<<< HEAD
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
=======
import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart'; // Assuming you have the Tasks model here
import 'package:task_manager/services/database_services/task_services.dart'; // Assuming FirestoreService is here

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  // Date and Time handling
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _taskNameController,
                decoration: const InputDecoration(labelText: "Task Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: _selectDate,
                child: Text(_selectedDate == null
                    ? 'Select Task Date'
                    : 'Date: ${_selectedDate!.toLocal()}'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: _selectTime,
                child: Text(_selectedTime == null
                    ? 'Select Task Time'
                    : 'Time: ${_selectedTime!.format(context)}'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Prepare data to add
                    final taskId = _firestoreService.generateTaskId(); // Assuming you have a method for this
                    final taskName = _taskNameController.text;
                    final dateOfUpload = _selectedDate.toString().split(' ')[0];
                    final timeOfUpload = _selectedTime!.format(context);
                    final uploadMilliSecond = DateTime.now().millisecondsSinceEpoch;

                    Tasks newTask = Tasks(
                      taskId: taskId,
                      taskName: taskName,
                      dateOfUpload: dateOfUpload,
                      timeOfUpload: timeOfUpload,
                      uploadMilliSecond: uploadMilliSecond,
                    );

                    // Add task to Firestore
                    await _firestoreService.addTask(newTask);

                    // Show success message and navigate back
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Task Added')),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to select date
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Method to select time
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }
}
>>>>>>> b42ce23 (Intial Commit)
