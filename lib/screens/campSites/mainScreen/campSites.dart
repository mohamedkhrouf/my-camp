import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/campSites/widgets/campSite.dart';

class CampSites extends StatefulWidget {
  @override
  _CampSites createState() => _CampSites();
}

class _CampSites extends State<CampSites> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Container(
                      margin: EdgeInsets.all(16.0),
                      child: Row(children: [
                        new Flexible(
                            child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: 'Enter your task',
                              contentPadding: EdgeInsets.only(left: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90.0))),
                              prefixIcon: Icon(Icons.search)),
                        )),
                      ]))),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
              CampSite(),
            ],
          ),
        ),
        Positioned(
            right: 15.0,
            bottom: 10.0,
            child: ElevatedButton(
              onPressed: null,
              child: Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(30),
                primary: Colors.blue, // <-- Button color
                onPrimary: Colors.red, // <-- Splash color
              ),
            )),
      ],
    );
  }
}
