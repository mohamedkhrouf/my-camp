

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ImageContainer extends StatefulWidget {
 final String imagePath ;
   int index ;
 final void Function(int index) deleteImage;

  ImageContainer({Key keyImageContainer, this.imagePath, this.index, this.deleteImage}) : super(key: keyImageContainer);
  @override
  _ImageContainer createState() => _ImageContainer();
}

class _ImageContainer extends State<ImageContainer> {
  int index ;
  void updateIndex() {
    setState(() {
      widget.index = widget.index-1;
    });}
  @override
  Widget build(BuildContext context) {
    index=widget.index;
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      width: 80,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          fit: BoxFit.fitHeight,

          image: NetworkImage(widget.imagePath),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      child: Center(
        child:GestureDetector(
          onTap: (){
            setState(() {
              widget.deleteImage(widget.index);

            });

          },
          child:Icon(
            Icons.delete,
            color: Colors.grey,
          ),
        )
      ),
    );
  }
}