import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddImage extends StatefulWidget {
  @override
  _AddImage createState() => _AddImage();
}

class _AddImage extends State<AddImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey,

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      child: Center(
        child: Icon(Icons.add),
      ),
    );
  }
}
