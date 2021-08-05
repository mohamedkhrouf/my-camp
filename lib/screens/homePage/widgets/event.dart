import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/comments/mainScreen/evComment.dart';
import 'package:my_camp/screens/comments/widgets/comment.dart';
import 'package:my_camp/screens/homePage/mainScreen/mapPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_camp/screens/homePage/widgets/visitedProfile.dart';

class EvPage extends StatefulWidget {
  @override
  _EvPageState createState() => _EvPageState();
  final yep;
  final id;

  const EvPage({Key key, this.yep, this.id}) : super(key: key);
}

class _EvPageState extends State<EvPage> {
  var clicked = false;
  var user;

  List commentList=[];
  @override
  void initState() {
    super.initState();

    getComments();
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

  List getComments() {
    List documents;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('event').doc(widget.id).collection("comments");

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
          .collection('event')
          .doc(widget.id)
          .update({
            'likes': FieldValue.arrayRemove([userId])
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    } else {
      FirebaseFirestore.instance
          .collection('event')
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
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VisitedProfilePage(userId: widget.yep["adminId"].id)),
                          );
                        },
                        child: Text(
                          user != null ? user.data()["username"] : "",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ) ,
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Container(
                      child: Text(
                        DateFormat('dd/MM/yyyy')
                            .format(DateTime.fromMicrosecondsSinceEpoch(widget
                                .yep["publicationDate"].microsecondsSinceEpoch))
                            .toString(),
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(right: 40),
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
        Container(
            child: Stack(
          children: [
            Image.network(
              widget.yep["images"][0],
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              bottom: 20,
              left: 60,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: widget.yep["pendingUsers"]
                              .contains((FirebaseAuth.instance.currentUser).uid)
                          ? OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Colors.brown),
                                  primary: Colors.white,
                                  padding: !clicked
                                      ? EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 50,
                                          right: 50)
                                      : EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 32.5,
                                          right: 32.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                  )),
                              onPressed: () {},
                              child: Text('Pending...'),
                            )
                          : OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Colors.brown),
                                  primary: Colors.white,
                                  padding: !clicked
                                      ? EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 50,
                                          right: 50)
                                      : EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 32.5,
                                          right: 32.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                  )),
                              onPressed: () {
                                setState(() {
                                  FirebaseFirestore.instance
                                      .collection('demand')
                                      .add({
                                    'eventId': FirebaseFirestore.instance
                                        .doc("event/" + widget.id),
                                    'userId': FirebaseFirestore.instance.doc(
                                        "user/" +
                                            (FirebaseAuth.instance.currentUser)
                                                .uid),
                                    'state': "pending",
                                    'receiverId': FirebaseFirestore.instance
                                        .doc("user/" + user.id)
                                  }).then((value) => FirebaseFirestore.instance
                                              .collection('event')
                                              .doc(widget.id)
                                              .update({
                                            'pendingUsers':
                                                FieldValue.arrayUnion([
                                              (FirebaseAuth
                                                      .instance.currentUser)
                                                  .uid
                                            ])
                                          }));
                                });
                                FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .update({
                                      'events': FieldValue.arrayUnion([
                                        FirebaseFirestore.instance
                                            .collection('event')
                                            .doc(widget.id)
                                      ])
                                    })
                                    .then((value) => print("ok"))
                                    .catchError((error) => print(
                                        "Failed to update event: $error"));
                              },
                              child: Text('Join'),
                            ),
                      margin: EdgeInsets.only(right: 20),
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                              top: 15, bottom: 15, left: 50, right: 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          )),
                        ),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapPage(latitude: widget.yep["latitude"] ,longitude: widget.yep["longitude"] ,)))
                        },
                        child: Text('Map'),
                      ),
                      margin: EdgeInsets.only(left: 20),
                    )
                  ]),
            ),
          ],
        )),
        Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.only(left: 10.0, top: 10.0),
            color: Color.fromRGBO(255, 255, 255, 1),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      height: 500,
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
                ),
                SizedBox(height: 6.0),
                Text(
                  "Event Name: " + widget.yep["name"],
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  child: Text(
                    widget.yep["description"],
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
