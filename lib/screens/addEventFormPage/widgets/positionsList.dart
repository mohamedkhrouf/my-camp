import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/campSiteForm/mainScreen/campSiteForm.dart';
import 'package:my_camp/screens/addEventFormPage/widgets/campSite.dart';

class PositionsList extends StatefulWidget {
  @override
  final void Function(dynamic pos) getPosition;

  const PositionsList({Key key, this.getPosition}) : super(key: key);
  _PositionsList createState() => _PositionsList();
}

class _PositionsList extends State<PositionsList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List campList = [];
  List shownCampingSites = [] ;

  @override
  void initState() {
    super.initState();
    getCamps();
  }

  List getCamps() {
    List documents;
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('place');

    collectionReference.snapshots().listen((snapshot) {
      if (mounted) {
        setState(() {
          campList = snapshot.docs;
          shownCampingSites= campList ;

          //print(documents[3].data());
          // usersList = snapshot.docs;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
            backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            leading: IconButton(
              icon:
              Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
              onPressed: () => Navigator.of(context).pop(),
            ),
        title: Text("Camp sites"),
        ),
        body:
        Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Container(
                        margin: EdgeInsets.all(16.0),
                        child: Row(children: [
                          new Flexible(
                              child: TextFormField(
                                onChanged: (text) {
                                  print(text);
                                  setState(() {
                                    shownCampingSites = campList
                                        .where(
                                            (e) => e.data()["name"].contains(text))
                                        .toList();
                                  });
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Enter camp site',
                                    contentPadding: EdgeInsets.only(left: 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(90.0))),
                                    prefixIcon: Icon(Icons.search)),
                              )),
                        ]))),
                ...shownCampingSites.map((e) {
                  return CampSite(data:e.data(), id : e.id, getPosition: widget.getPosition,);
                }),
              ],
            ),
          ),

    ));
  }
}
