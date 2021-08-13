import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/campSiteForm/mainScreen/campSiteForm.dart';
import 'package:my_camp/screens/campSites/widgets/campSite.dart';

class CampSites extends StatefulWidget {
  @override
  _CampSites createState() => _CampSites();
}

class _CampSites extends State<CampSites> {
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
    return Stack
    (
      children: [
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
                                  hintText: 'Search',
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(90.0))),
                                  prefixIcon: Icon(Icons.search)),
                            )),
                      ]))),
              ...shownCampingSites.map((e) {
                return CampSite(data:e.data());
              })
            ],
          ),
        ),)
        ,
        Container(
          child: Positioned(
              right: 15,
              bottom: 25,
              child:Center(child :ElevatedButton(
                onPressed: ()=>{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CampSiteForm()),
                  )
                },
                child: Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(30),
                  primary: Colors.blue, // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
              )) ),
        )
        
      ],
    );
  }
}
