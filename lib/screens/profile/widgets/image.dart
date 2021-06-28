import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/homePage/mainScreen/mapPage.dart';

class ImagePage extends StatefulWidget {
  final String url;

  const ImagePage({Key key, this.url}) : super(key: key);
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(color: Colors.amber),
      child: Image.asset(
        widget.url,
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

/*  */

/* Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child:  Image.asset(
                  'assets/mekki.jpg',
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              ); */
