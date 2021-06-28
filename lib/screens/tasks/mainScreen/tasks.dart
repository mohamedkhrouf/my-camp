import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/tasks/widgets/task.dart';
import 'package:my_camp/screens/tasks/widgets/tasksAppBar.dart';

class TaskModel {
  TaskModel({this.taskName, this.state});

  final String taskName;
  final bool state;
}

class Tasks extends StatefulWidget {
  @override
  _Tasks createState() => _Tasks();
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
];

class _Tasks extends State<Tasks> {
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
    return Scaffold(
        appBar: PreferredSize(
          child: TasksAppBar(),
          preferredSize: const Size.fromHeight(100),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
              Form(
                  key: _formKey,
                  child: Container(
                      margin: EdgeInsets.all(16.0),

                      child:Row (children:[
                        new Flexible(child: TextFormField(
                          controller: taskController ,
                          decoration: const InputDecoration(
                              hintText: 'Enter your task',
                              contentPadding: EdgeInsets.only(left: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(90.0))),
                              prefixIcon: Icon(Icons.search)),

                          )
                        ),
                        Container(

                            margin: EdgeInsets.only(left: 5),
                            child:ElevatedButton(
                            onPressed: (){
                              setState(() {
                                allTasks.add(new TaskModel(taskName: taskController.text, state: true));

                              });
                            },
                            child: Text("Add"),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.all(20.0)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    )))

                        ))
                      ]
                      )
            )
        ),
              ListView.builder(
                  shrinkWrap: true,
                itemCount: allTasks.length,
                itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                        border: Border(bottom:BorderSide(width: 0.5,color: Color.fromRGBO(241,220,255 ,1)),)
                    ),
                    child:Task(taskName: allTasks[index].taskName));
              })
        ])));
  }
}
