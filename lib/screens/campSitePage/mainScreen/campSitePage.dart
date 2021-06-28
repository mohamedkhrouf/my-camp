import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CampSitePage extends StatefulWidget {
  @override
  _CampSitePage createState() => _CampSitePage();
}

class _CampSitePage extends State<CampSitePage> {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        title: Text("Camp Site"),
      ),
    );
  }
}