import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_camp/screens/homePage/widgets/visitedProfile.dart';
import 'package:my_camp/screens/comments/widgets/comment.dart';

class Cont extends StatefulWidget {
  @override
  _ContState createState() => _ContState();
  final yep;
  final id;
  const Cont({Key key, this.yep, this.id}) : super(key: key);
}

class _ContState extends State<Cont> {
  var items = [];
  var ind = 1;
  var user;
  List commentList=[];

  @override
  void initState() {
    super.initState();
    getComments();
    getUser();
    widget.yep["images"].forEach((e) {
      items.add(e.toString());
      print(e.toString());
    });
    print(liked());
    print(widget.yep["likes"].toString());
    print(widget.id);
  }

  getUser() {
//    CollectionReference collectionReference =FirebaseFirestore.instance.collection('user');
    String uid = widget.yep["userId"].id;
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
  List getComments() {
    List documents;
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('post').doc(widget.id).collection("comments");

    collectionReference.snapshots().listen((snapshot) {
      if (mounted) {
        setState(() {
          commentList = snapshot.docs;

          //print(documents[3].data());
          // usersList = snapshot.docs;
        });
      }
    });
  }
  nblikes() {
    return widget.yep["likes"].length;
  }

  liked() {
    if (widget.yep["likes"]
        .toString()
        .contains((FirebaseAuth.instance.currentUser).uid)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> like() {
    String userId = (FirebaseAuth.instance.currentUser).uid;

    if (widget.yep["likes"]
        .toString()
        .contains((FirebaseAuth.instance.currentUser).uid)) {
      FirebaseFirestore.instance
          .collection('post')
          .doc(widget.id)
          .update({
            'likes': FieldValue.arrayRemove([userId])
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    } else {
      FirebaseFirestore.instance
          .collection('post')
          .doc(widget.id)
          .update({
            'likes': FieldValue.arrayUnion([userId])
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Color.fromRGBO(188, 224, 253, 1),
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Spacer(),
                Container(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(user != null
                        ? user.data()["avatar"]
                        : "https://images.squarespace-cdn.com/content/v1/5d9cceda4305a15ce8619c7e/1574894159388-EUV3A0SC8ZZXQXMN7RAL/ke17ZwdGBToddI8pDm48kKPxQF3y6ACiilOwP4hijyt7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UdvLbAfL5pxwrgbwpvOCYZ-gFZWzBm2i02YX3WjdvL58ZDqXZYzu2fuaodM4POSZ4w/grey.png?format=2500w"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Spacer(),
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child:GestureDetector(
                    onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => VisitedProfilePage(userId: widget.yep["userId"].id)),
                );
                },child: Text(
                        user != null ? user.data()["username"] : "",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),

                    )
                    ),
                    Container(
                      child: Text(
                        widget.yep != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(DateTime.fromMicrosecondsSinceEpoch(
                                    widget.yep["publicationDate"]
                                        .microsecondsSinceEpoch))
                                .toString()
                            : "",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                )),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
              ],
            )),
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              like();
            });
          },
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      ind = index + 1;
                    });
                  },
                  height: MediaQuery.of(context).size.width * 0.8,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                ),
                items: items.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(i,
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitHeight);
                    },
                  );
                }).toList(),
              ),
              Positioned(
                  right: 10,
                  top: 5,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 20,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Container(
                        child: Text(
                          ' $ind/${widget.yep["images"].length}',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                        margin: EdgeInsets.only(top: 2),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Container(
            color: Color.fromRGBO(255, 255, 255, 1),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              like();
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.fire,
                            color: liked()
                                ? Color.fromRGBO(207, 53, 46, 1)
                                : Color.fromRGBO(0, 0, 0, 1),
                            size: 27,
                          ),
                        ),
                        margin: EdgeInsets.only(right: 20),
                      ),
                      Container(
                        child: GestureDetector(
                          child: Icon(
                            FontAwesomeIcons.commentDots,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            size: 27,
                          ),
                          onTap: () {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0)),
                              ),
                              builder: (BuildContext context) {
                                return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                        height: MediaQuery.of(context).size.height*0.85,
                                        child: Wrap(
                                          children: <Widget>[
                                            Container(
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(

                                                    width: double.infinity,
                                                    color: Colors.black54,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          topLeft:
                                                          Radius.circular(25),
                                                          topRight:
                                                          Radius.circular(25),
                                                        )),
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          top: 50, bottom: 100),
                                                      child: commentList.length ==
                                                          0
                                                          ? Center(
                                                        child: Text(
                                                            "No comments"),
                                                      )
                                                          : SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            ...commentList
                                                                .map((e) {
                                                              return Comment(
                                                                comment: e,
                                                                eventId:
                                                                widget
                                                                    .id,
                                                              );
                                                            }),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),

                                            Form(

                                                child: Container(

                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 64,
                                                          color: Color(0xFF087949)
                                                              .withOpacity(0.4),
                                                          offset: Offset(0,
                                                              5), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        top: 8.0,
                                                        right: 16.0,
                                                        left: 16.0,
                                                        bottom: 8.0),
                                                    child: Row(children: [
                                                      /* GestureDetector(
                          onTap: () {
                            setState(() {
                              print("hrgnrs");
                            });
                          },
                          child:Container(

                              child:Icon(
                            Icons.image,
                            color: Color.fromRGBO(170, 215, 62, 1),
                            size: 40,
                          ))),*/
                                                      new Flexible(
                                                          child: Container(
                                                              height: 35,
                                                              child:
                                                              TextFormField(

                                                                decoration:
                                                                const InputDecoration(
                                                                  hintText:
                                                                  'Enter your message',
                                                                  contentPadding:
                                                                  EdgeInsets.only(
                                                                      left:
                                                                      15.0),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(90.0))),
                                                                ),
                                                              ))),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5),
                                                        child: GestureDetector(
                                                            onTap: () async {
                                                              final newMessage =
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                  'event')
                                                                  .doc()
                                                                  .collection(
                                                                  'messages')
                                                                  .add({
                                                                'eventId':
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .doc(
                                                                    "event/"),
                                                                'senderId': FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                    'user')
                                                                    .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    .uid),


                                                                'sendTime':
                                                                DateTime.now()
                                                              });



                                                              /* messages.add(ChatMessage(
                                  message: messageController.text,
                                  messageType: MessageType.sent,
                                ));
                                messageController.clear();*/
                                                            },
                                                            child: Icon(
                                                              Icons.send,
                                                              color:
                                                              Color.fromRGBO(
                                                                  170,
                                                                  215,
                                                                  62,
                                                                  1),
                                                              size: 33,
                                                            )),
                                                      ),
                                                    ]))),
                                          ],
                                        )));
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 10, top: 10),
                ),
                Container(
                  child: Text(
                    widget.yep["text"],
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  margin: EdgeInsets.only(left: 10, right: 10),
                ),
              ],
            ))
      ],
    );
  }
}
