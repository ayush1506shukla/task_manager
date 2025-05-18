import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart'; // Make sure to import the Tasks model
import 'package:task_manager/services/database_services/task_services.dart'; // Import your Firestore service

class ViewIndividualTask extends StatefulWidget {
  final Tasks task;

  const ViewIndividualTask({Key? key, required this.task}) : super(key: key);

  @override
  State<ViewIndividualTask> createState() => _ViewIndividualTaskState();
}

class _ViewIndividualTaskState extends State<ViewIndividualTask> {
  final FirestoreService _firestoreService = FirestoreService(); // Initialize Firestore service
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDateController = TextEditingController();
  final TextEditingController _taskTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with existing task details
    _taskNameController.text = widget.task.taskName;
    _taskDateController.text = widget.task.dateOfUpload;
    _taskTimeController.text = widget.task.timeOfUpload;
  }

  void _editTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Update the task in Firestore
                await _firestoreService.updateTask(
                  widget.task.taskId, // Assuming you have taskId to identify the task
                  _taskNameController.text,
                  _taskDateController.text,
                  _taskTimeController.text,
                );
                Navigator.of(context).pop(); // Close the dialog
                setState(() {}); // Refresh the UI
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        title: Text(
          "Task Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.assignment,
                  color: Colors.black,
                  size: screenWidth / 17.25,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(screenWidth / 10.35),
                ),
                height: screenWidth / 10.35,
                width: screenWidth / 10.35,
              ),
              trailing: IconButton(
                onPressed: _editTask, // Call edit function
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: screenWidth / 17.25,
                ),
              ),
              title: Text(
                "Task Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth / 27.6),
              ),
              subtitle: Text(
                widget.task.taskName,
                style: TextStyle(fontSize: screenWidth / 31.85),
              ),
            ),
            SizedBox(height: screenWidth / 25.81),
            Divider(height: 0, color: Color(0xFFC4C4C4), indent: screenWidth / 21.79, endIndent: screenWidth / 21.79),
            ListTile(
              leading: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                  size: screenWidth / 17.25,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(screenWidth / 10.35),
                ),
                height: screenWidth / 10.35,
                width: screenWidth / 10.35,
              ),

              title: Text(
                "Task Date",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth / 27.6),
              ),
              subtitle: Text(
                widget.task.dateOfUpload,
                style: TextStyle(fontSize: screenWidth / 31.85),
              ),
            ),
            Divider(height: 0, color: Color(0xFFC4C4C4), indent: screenWidth / 21.79, endIndent: screenWidth / 21.79),
            ListTile(
              leading: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.watch,
                  color: Colors.black,
                  size: screenWidth / 17.25,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(screenWidth / 10.35),
                ),
                height: screenWidth / 10.35,
                width: screenWidth / 10.35,
              ),
              
              title: Text(
                "Task Time",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth / 27.6),
              ),
              subtitle: Text(
                widget.task.timeOfUpload,
                style: TextStyle(fontSize: screenWidth / 31.85),
              ),
            ),
            Divider(height: 0, color: Color(0xFFC4C4C4), indent: screenWidth / 21.79, endIndent: screenWidth / 21.79),
          ],
        ),
      ),
    );
  }
}
