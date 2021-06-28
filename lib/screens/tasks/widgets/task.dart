import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/tasks/widgets/takeTaskButton.dart';

class Task extends StatefulWidget{
  final String taskName ;

  const Task({Key key, this.taskName}) : super(key: key);

  @override
  _Task createState() => _Task();
}
class _Task extends State<Task>{

  @override
  Widget build(BuildContext context)
  {
    return ListTile(
        leading: Icon(Icons.person),
        title: Row(

            children :[
              Text(widget.taskName),
              Spacer(),
              TakeTaskButton(),
            ]
        )
    );
  }
}