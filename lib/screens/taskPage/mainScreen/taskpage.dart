import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/taskPage/widgets/task.dart';

class TaskModel {
  TaskModel({this.taskName, this.state});

  final String taskName;
  final bool state;
}

class TaskPage extends StatefulWidget {
  @override
  _TaskPage createState() => _TaskPage();
}

List<TaskModel> allTasks = [
  new TaskModel(taskName: "task 1 .....", state: true),
  new TaskModel(taskName: "task 2 .....", state: true),
  new TaskModel(taskName: "task 3 .....", state: true),
  new TaskModel(taskName: "task 4 .....", state: true),
  new TaskModel(taskName: "task 75 .....", state: true),
  new TaskModel(taskName: "task 8 .....", state: true),
  new TaskModel(taskName: "task 7 .....", state: true),
  new TaskModel(taskName: "task 9 .....", state: true),
  new TaskModel(taskName: "task 10 .....", state: true),
  new TaskModel(taskName: "task 11 .....", state: true),
  new TaskModel(taskName: "task 11 .....", state: true),
  new TaskModel(taskName: "task 11 .....", state: true),
  new TaskModel(taskName: "task 11 .....", state: true),
  new TaskModel(taskName: "task 11 .....", state: true),
  new TaskModel(taskName: "task 11 .....", state: true),
];

class _TaskPage extends State<TaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin : EdgeInsets.only(top:40),
        child: SingleChildScrollView(
      child: Column(
        
          children: allTasks
              .map((item) => new Task(taskName: item.taskName))
              .toList()),
    ));
    
  }
}
