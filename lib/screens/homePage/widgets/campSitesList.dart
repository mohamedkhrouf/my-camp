import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CampSitesList extends StatefulWidget {
  @override
  _CampSitesList createState() => _CampSitesList();
}

class _CampSitesList extends State<CampSitesList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 34, 47, 1)
    ,
    leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
    onPressed: () => Navigator.of(context).pop(),
    ),


    ),);
  }
  }
