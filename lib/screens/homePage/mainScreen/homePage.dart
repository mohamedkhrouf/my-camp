import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/addEventFormPage/mainScreen/addEventForm.dart';
import 'package:my_camp/screens/homePage/widgets/event.dart';
import 'package:my_camp/screens/homePage/widgets/publication.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List eventList = [];
  var publication = false;
  var event = false;
  var user;
  List postList = [];
  @override
  void initState() {
    super.initState();
    getEvents();
    getPosts();
    getUser();
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
    return user;
  }

  List getEvents() {
    List documents;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('event');

    collectionReference.snapshots().listen((snapshot) {
      if (mounted) {
        setState(() {
          eventList = snapshot.docs;
          //print(documents[3].data());
          // usersList = snapshot.docs;
        });
      }
    });
  }

  List getPosts() {
    List documents;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('post');

    collectionReference.snapshots().listen((snapshot) {
      if (mounted) {
        setState(() {
          postList = snapshot.docs;

          //print(documents[3].data());
          // usersList = snapshot.docs;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30.0, bottom: 16.0),
            child: (publication || event)
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    OutlinedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: 15, bottom: 15, left: 30, right: 30)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30)),
                        )),
                      ),
                      onPressed: () {
                        setState(() {
                          publication = false;
                          event = false;
                        });
                      },
                      child: Text('Publications'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: 15, bottom: 15, left: 50, right: 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        )),
                      ),
                      onPressed: () => {
                        setState(() {
                          publication = true;
                          event = true;
                        })
                      },
                      child: Text('Events'),
                    ),
                  ])
                : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: 15, bottom: 15, left: 30, right: 30)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30)),
                        )),
                      ),
                      onPressed: () => {
                        setState(() {
                          publication = false;
                          event = false;
                        })
                      },
                      child: Text('Publications'),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: 15, bottom: 15, left: 50, right: 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        )),
                      ),
                      onPressed: () {
                        setState(() {
                          publication = true;
                          event = false;
                        });
                      },
                      child: Text('Events'),
                    ),
                  ]),
          ),
          !publication
              ? Column(
                  children: [
                    ...postList.map((e) {

                      return Cont(yep: e.data(), id: e.id);
                    })
                  ],
                )
              : Column(children: [
                  Container(
                      margin: EdgeInsets.only(left: 16.0,right: 16.0,bottom: 16.0),
                      child: Row(children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(user!=null?user.data()["avatar"]:"https://images.squarespace-cdn.com/content/v1/5d9cceda4305a15ce8619c7e/1574894159388-EUV3A0SC8ZZXQXMN7RAL/ke17ZwdGBToddI8pDm48kKPxQF3y6ACiilOwP4hijyt7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UdvLbAfL5pxwrgbwpvOCYZ-gFZWzBm2i02YX3WjdvL58ZDqXZYzu2fuaodM4POSZ4w/grey.png?format=2500w"),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        new Flexible(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddEventForm(user: user)),
                              );
                            },
                            child: SizedBox(
                              height: 36,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Container(
                                padding: EdgeInsets.only(left: 16.0, top: 10,bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(color: Colors.black)),
                                child: Text(
                                  'Add a new event...',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        )
                      ])),
                  Column(
                    children: [
                      ...eventList.map((e) {

                        return EvPage(yep: e.data(),id:e.id);
                      }),
                    ],
                  )
                ])
        ],
      ),
    );
  }
}
