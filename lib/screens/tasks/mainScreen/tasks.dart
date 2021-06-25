import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/tasks/widgets/takeTaskButton.dart';
import 'package:my_camp/screens/tasks/widgets/task.dart';
import 'package:my_camp/screens/tasks/widgets/tasksAppBar.dart';
class TaskModel{
  TaskModel({this.taskName,  this.state});
  final String taskName;
  final bool state ;
}
class Tasks extends StatefulWidget {
  @override
  _Tasks createState() => _Tasks();
}
List<TaskModel> allTasks = [
  new TaskModel(taskName: "task 1 .....",state: true),
  new TaskModel(taskName: "task 2 .....",state: true),
  new TaskModel(taskName: "task 3 .....",state: true),
  new TaskModel(taskName: "task 4 .....",state: true),
  new TaskModel(taskName: "task 75 .....",state: true),
  new TaskModel(taskName: "task 8 .....",state: true),
  new TaskModel(taskName: "task 7 .....",state: true),
  new TaskModel(taskName: "task 9 .....",state: true),
  new TaskModel(taskName: "task 10 .....",state: true),
  new TaskModel(taskName: "task 11 .....",state: true),

];
class _Tasks extends State<Tasks> {
  var taskList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: TasksAppBar(),
        preferredSize: const Size.fromHeight(100),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: allTasks.length,
              itemBuilder: (context,index){
                return Task(taskName : allTasks[index].taskName);
              }
          )
      ),
    );
  }
}
