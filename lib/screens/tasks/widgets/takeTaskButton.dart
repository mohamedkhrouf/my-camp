import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TakeTaskButton extends StatefulWidget{
  final taskId ;


  const TakeTaskButton( {Key key, this.taskId}) : super(key: key);@override
  _TakeTaskButton createState() => _TakeTaskButton();
}
class _TakeTaskButton extends State<TakeTaskButton>{
  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      onPressed: () {

            FirebaseFirestore.instance.collection('task').doc(widget.taskId).update(
                {
                  'userId': FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser.uid)
                });
      },
      child: Icon(Icons.add, color: Colors.white),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        primary: Color.fromRGBO(170, 215, 62, 1), // <-- Button color
        onPrimary: Colors.red, // <-- Splash color
      ),
    );
  }
}