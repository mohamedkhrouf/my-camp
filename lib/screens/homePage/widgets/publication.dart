import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cont extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 200.0,
      width: 300.0,
      margin: EdgeInsets.all(16),
      child: Text("Hello"),
    );

  }
}