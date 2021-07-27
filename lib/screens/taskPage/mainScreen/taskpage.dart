import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/taskPage/widgets/task.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPage createState() => _TaskPage();
}

class _TaskPage extends State<TaskPage> {
  List taskList = [];
  var num = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getTasks();
  }

  List getTasks() {
    List documents;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('task');

    collectionReference.snapshots().listen((snapshot) {
      if (mounted) {
        setState(() {
          taskList = snapshot.docs;
          //print(documents[3].data());
          // usersList = snapshot.docs;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40),
        child: taskList.length==0
            ?
        Center(child: Text("No tasks"))
            :SingleChildScrollView(
            child: Column(
          children: [
            ...taskList.map((item) {
              if (item.data()["userId"] != null) {
                if (item.data()["userId"].id ==
                    (((FirebaseAuth.instance.currentUser).uid))) {
                  num = num + 1;
                  return new Task(data: item.data(), id: item.id);
                } else {
                  return Container();
                }
              }else{
                 return Container();
              }
            }).toList(),
          ],
        )));
  }
}
