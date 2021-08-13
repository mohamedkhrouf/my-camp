import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:my_camp/screens/Notifications/widgets/notif.dart';
import 'package:my_camp/screens/Notifications/widgets/placeN.dart';

class NotifPage extends StatefulWidget {
  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  List notifs = [];
  List places = [];
  var user;
  @override
  void initState() {
    super.initState();
    getNotifs();
    getPlaces();
    getUser();
  }

  List getNotifs() {
    List documents;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('demand');

    collectionReference.snapshots().listen((snapshot) {
      if (mounted) {
        setState(() {
          notifs = snapshot.docs;
          //print(documents[3].data());
          // usersList = snapshot.docs;
        });
      }
    });
  }

  List getPlaces() {
    List documents;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('place');

    collectionReference
        .where("pending", isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      if (mounted) {
        setState(() {
          places = snapshot.docs;
          //print(documents[3].data());
          // usersList = snapshot.docs;
        });
      }
    });
  }

  getUser() {
//    CollectionReference collectionReference =FirebaseFirestore.instance.collection('user');
    String uid = (FirebaseAuth.instance.currentUser).uid;
    print(uid);
    FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
      if (mounted) {
        setState(() {
          user = value;
        });
      }
    });
  }

  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(90.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(36, 34, 47, 1),
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: (notifs.length == 0 && places.length == 0)
            ? Center(child: Text("No notifications"))
            : SingleChildScrollView(
                child: Column(children: [
                ...notifs.map((item) {
                  if (item.data()["receiverId"] != null) {
                    if (item.data()["receiverId"].id ==
                        (((FirebaseAuth.instance.currentUser).uid))) {
                      return new Notif(demand: item.data(), id: item.id);
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                }).toList(),
                ...places.map((item) {
                  if (user != null) {
                    if (user.data()["admin"] != false) {
                     
                        
                          return new PlaceN(demand: item.data(), id: item.id);
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
              
                }).toList(),
              ])));
  }
}
