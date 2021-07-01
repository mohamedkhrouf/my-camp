import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TasksAppBar extends StatefulWidget{
  @override
  _TasksAppBar createState() => _TasksAppBar();
}
class _TasksAppBar extends State<TasksAppBar>{
  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Icon(Icons.arrow_back),
                  margin: EdgeInsets.only(right: 20.0),
                ),
              ),
              Text(
                "Tasks",
                style: TextStyle(fontSize: 20),
              ),

            ],
          ),
          padding: EdgeInsets.all(16.0),
        );
  }


}