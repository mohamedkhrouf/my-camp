import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TakeTaskButton extends StatefulWidget{
  @override
  _TakeTaskButton createState() => _TakeTaskButton();
}
class _TakeTaskButton extends State<TakeTaskButton>{
  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      onPressed: () {},
      child: Icon(Icons.add, color: Colors.white),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        primary: Colors.blue, // <-- Button color
        onPrimary: Colors.red, // <-- Splash color
      ),
    );
  }
}