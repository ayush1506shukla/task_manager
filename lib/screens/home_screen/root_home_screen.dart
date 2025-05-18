import 'package:flutter/material.dart';
import 'package:task_manager/services/database_services/task_services.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/screens/home_screen/sub_screens/add_task_screen.dart';
import 'package:task_manager/screens/home_screen/sub_screens/view_individual_task.dart';
import 'package:task_manager/screens/home_screen/sub_screens/notebook_screen.dart'; // Import the NotebookScreen
import 'package:task_manager/screens/auth_screens/login_screen/login_screen.dart';

class RootHomeScreen extends StatefulWidget {
  const RootHomeScreen({Key? key}) : super(key: key);

  @override
  State<RootHomeScreen> createState() => _RootHomeScreenState();
}

class _RootHomeScreenState extends State<RootHomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddTaskScreen()),
              );
            },
            icon: Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NotebookScreen()), // Navigate to NotebookScreen
              );
            },
            icon: Icon(Icons.note_add, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.exit_to_app, color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ],
        title: Text(
          "Hello Ayush",
          style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: StreamBuilder<List<Tasks>>(
        stream: _firestoreService.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks available'));
          }
          final tasks = snapshot.data!;

          // Sort tasks by date
          tasks.sort((a, b) {
            DateTime dateA = DateTime.parse(a.dateOfUpload);
            DateTime dateB = DateTime.parse(b.dateOfUpload);
            return dateA.compareTo(dateB); // Sort in ascending order
          });

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return IndividualTaskBuilder(
                screenWidth: screenWidth,
                taskName: task.taskName,
                taskDate: task.dateOfUpload,
                taskTime: task.timeOfUpload,
                onDeletePressed: () {
                  _showDeleteConfirmationDialog(context, task.taskId);
                },
                onPressed: () {
                  // Navigate to view task details
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ViewIndividualTask(task: task)),
                  );
                },
                index: index,
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await _firestoreService.deleteTask(taskId); // Call the delete function
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}

class IndividualTaskBuilder extends StatelessWidget {
  const IndividualTaskBuilder({
    Key? key,
    required this.screenWidth,
    required this.taskName,
    required this.taskDate,
    required this.taskTime,
    required this.onPressed,
    required this.onDeletePressed,
    required this.index,
  }) : super(key: key);

  final double screenWidth;
  final int index;
  final String taskName, taskDate, taskTime;
  final VoidCallback onPressed, onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              trailing: GestureDetector(
                onTap: onDeletePressed,
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.delete,
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
              ),
              title: Text(
                "Task Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth / 27.6),
              ),
              subtitle: Text(
                "$taskName",
                style: TextStyle(fontSize: screenWidth / 31.85),
              ),
            ),
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
                "$taskDate",
                style: TextStyle(fontSize: screenWidth / 31.85),
              ),
            ),
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
                "$taskTime",
                style: TextStyle(fontSize: screenWidth / 31.85),
              ),
            ),
          ],
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
          borderRadius: BorderRadius.circular(screenWidth / 41.4),
        ),
        width: screenWidth,
        margin: EdgeInsets.only(
          left: screenWidth / 20.7,
          right: screenWidth / 20.7,
          bottom: screenWidth / 20.7,
          top: index == 0 ? screenWidth / 20.7 : 0,
        ),
      ),
    );
  }
}
