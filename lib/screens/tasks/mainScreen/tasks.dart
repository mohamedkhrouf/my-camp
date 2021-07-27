import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final eventId ;
  const Tasks({Key key, this.eventId}) : super(key: key);
  @override
  _Tasks createState() => _Tasks();
}



class _Tasks extends State<Tasks> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();
  var allTasks = [];
  var realTasks = [];
  var taskname= "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTasks();
  }
  getTasks(){
  FirebaseFirestore.instance.collection('task').
  snapshots().listen((snapshot) {
    if (mounted) {
    setState(() {
      allTasks=snapshot.docs;

    });}

  });
  
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(36, 34, 47, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Tasks",
            style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),
          ),

        ),
        body:
        SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              Form(
                  key: _formKey,
                  child: Container(
                      margin: EdgeInsets.all(16.0),

                      child:Row (children:[
                        new Flexible(child: TextFormField(
                          onChanged: (text){
                            setState(() {
                              taskname=taskController.text ;
                            });
                          },
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
                            child:taskname!=""?ElevatedButton(
                            onPressed: (){
                              setState(() {
                                FirebaseFirestore.instance.collection('task').add(
                                    {
                                      'checked' : false ,
                                      'eventId': FirebaseFirestore.instance.collection('event').doc(widget.eventId),
                                      'name' : taskController.text ,
                                      'userId' : null


                                    });

                              });
                              taskController.clear();
                            },
                            child: Text("Add",style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1) ),),
                            style: ElevatedButton.styleFrom(

                              primary:Color.fromRGBO(36, 34, 47, 1) ,
                                padding: EdgeInsets.only(right:20.0, left: 20.0 , top : 16 , bottom: 16)



                            )

                        ):ElevatedButton(
                                onPressed: (){


                                },
                                child: Text("Add",style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1) ),),
                                style: ElevatedButton.styleFrom(

                                    primary:Color.fromRGBO(36, 34, 47, 1) ,
                                    padding: EdgeInsets.only(right:20.0, left: 20.0 , top : 16 , bottom: 16)



                                )

                            ))
                      ]
                      )
            )
        ),
              ...allTasks.map((item) {
                if (item
                    .data()["eventId"]
                    .id == widget.eventId
                    ) {
                  return new Task(taskName: item.data()["name"],userId: item.data()["userId"],taskId: item.id,taskDone :item.data()["checked"]);
                } else {
                  return Container();
                }
              }).toList(),
            /*  ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                itemCount: allTasks.length,
                itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(left: 16.0, right: 3.5),
                    decoration: BoxDecoration(
                        border: Border(bottom:BorderSide(width: 0.5,color: Color.fromRGBO(241,220,255 ,1)),)
                    ),
                    child:Task(taskName: realTasks[index].data()["name"]));
              })*/
        ])));
  }
}
