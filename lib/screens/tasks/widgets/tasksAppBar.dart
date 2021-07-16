import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TasksAppBar extends StatefulWidget{
  @override
  _TasksAppBar createState() => _TasksAppBar();
}
class _TasksAppBar extends State<TasksAppBar>{
  @override
  Widget build(BuildContext context) {
    return  AppBar(
        backgroundColor: Color.fromRGBO(36, 34, 47, 1),
    leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
    onPressed: () => Navigator.of(context).pop(),
    ),
    title: Text(
    "Tasks",
    style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),
    ),

    );
  }


}