import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatefulWidget {
  @override
  _ImageContainer createState() => _ImageContainer();
}

class _ImageContainer extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage("assets/mekki.jpg"),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      child: Center(child: Icon(Icons.delete,color: Colors.grey,),),
    );
  }
}