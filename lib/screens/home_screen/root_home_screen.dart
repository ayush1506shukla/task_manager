import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services package
import 'package:task_manager/screens/home_screen/sub_screens/view_individual_task.dart';

class RootHomeScreen extends StatefulWidget {
  const RootHomeScreen({Key? key}) : super(key: key);

  @override
  State<RootHomeScreen> createState() => _RootHomeScreenState();
}

class _RootHomeScreenState extends State<RootHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0))),
          IconButton(
              onPressed: () {
                // Exit the app when the exit button is pressed
                SystemNavigator.pop(); // Use SystemNavigator to exit the app
              },
              icon: Icon(Icons.exit_to_app, color: const Color.fromARGB(255, 0, 0, 0))),
        ],
        title: Text(
          "Hello Ayush",
          style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: ListView(
        children: List.generate(
          1,
          (index) => IndividualTaskBuilder(
            screenWidth: screenWidth,
            taskDate: '12/12/12',
            taskName: 'Have food',
            taskTime: '07:55pm',
            onDeletePressed: () {},
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewIndividualTask()));
            },
            index: index,
          ),
        ),
      ),
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
                            color: Colors.black.withOpacity(0.25))
                      ],
                      borderRadius:
                          BorderRadius.circular(screenWidth / 10.35)),
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
                              color: Colors.black.withOpacity(0.25))
                        ],
                        borderRadius:
                            BorderRadius.circular(screenWidth / 10.35)),
                    height: screenWidth / 10.35,
                    width: screenWidth / 10.35,
                  ),
                ),
                title: Text("Task Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth / 27.6)),
                subtitle: Text(
                  "$taskName",
                  style: TextStyle(fontSize: screenWidth / 31.85),
                )),
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
                            color: Colors.black.withOpacity(0.25))
                      ],
                      borderRadius:
                          BorderRadius.circular(screenWidth / 10.35)),
                  height: screenWidth / 10.35,
                  width: screenWidth / 10.35,
                ),
                title: Text("Task Date",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth / 27.6)),
                subtitle: Text(
                  "$taskDate",
                  style: TextStyle(fontSize: screenWidth / 31.85),
                )),
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
                            color: Colors.black.withOpacity(0.25))
                      ],
                      borderRadius:
                          BorderRadius.circular(screenWidth / 10.35)),
                  height: screenWidth / 10.35,
                  width: screenWidth / 10.35,
                ),
                title: Text("Task Time",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth / 27.6)),
                subtitle: Text(
                  "$taskTime",
                  style: TextStyle(fontSize: screenWidth / 31.85),
                ))
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25))
          ],
          borderRadius: BorderRadius.circular(screenWidth / 41.4),
        ),
        width: screenWidth,
        margin: EdgeInsets.only(
            left: screenWidth / 20.7,
            right: screenWidth / 20.7,
            bottom: screenWidth / 20.7,
            top: index == 0 ? screenWidth / 20.7 : 0),
      ),
    );
  }
}
