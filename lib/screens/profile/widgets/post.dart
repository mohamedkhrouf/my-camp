import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_camp/screens/comments/mainScreen/postComment.dart';
import 'package:my_camp/screens/comments/widgets/comment.dart';
import 'package:my_camp/screens/comments/widgets/commentP.dart';
import 'package:my_camp/screens/profile/widgets/image.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
  final yep;
  final id;
  const PostPage({Key key, this.yep, this.id}) : super(key: key);
}

class _PostPageState extends State<PostPage> {
  var items = [];
  var ind = 1;
  var commentList = [];
  final messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getComments();
    widget.yep["images"].forEach((e) {
      items.add(e.toString());
      print(e.toString());
    });
  }

  List getComments() {
    List documents;
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('post')
        .doc(widget.id)
        .collection("comments");

    collectionReference.orderBy("date").snapshots().listen((snapshot) {
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
    return Container(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: [
          Stack(
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
                          widget.yep != null
                              ? ' $ind/${widget.yep["images"].length}'
                              : '',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                        margin: EdgeInsets.only(top: 2),
                      ),
                    ],
                  )),
            ],
          ),
          Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(children: [
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
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext bc) {
                                  return FractionallySizedBox(
                                    heightFactor: 0.85,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 40.0,
                                          width: double.infinity,
                                          color: Colors.black54,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 35),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25),
                                              )),
                                        ),
                                        Container(
                                            color: Colors.white,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Stack(children: [
                                              SingleChildScrollView(
                                                  child: Column(
                                                children: [
                                                  ...commentList.map((e) {
                                                    return CommentP(
                                                      comment: e,
                                                      eventId: widget.id,
                                                    );
                                                  }),
                                                ],
                                              )),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: MediaQuery.of(
                                                                      context)
                                                                  .viewInsets
                                                                  .bottom !=
                                                              0
                                                          ? MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom
                                                          : MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
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
                                                    new Flexible(
                                                        child: Container(
                                                            height: 35,
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  messageController,
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
                                                                        'post')
                                                                    .doc(widget
                                                                        .id)
                                                                    .collection(
                                                                        'comments')
                                                                    .add({
                                                              'eventId': FirebaseFirestore
                                                                  .instance
                                                                  .doc("event/" +
                                                                      widget
                                                                          .id),
                                                              'userId': FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'user')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      .uid),
                                                              'text':
                                                                  messageController
                                                                      .text,
                                                              'likes': [],
                                                              'date':
                                                                  DateTime.now()
                                                            });

                                                            messageController
                                                                .clear();

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
                                                  ])),
                                            ])),
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      )
                    ]),
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
      ),
    );
  }
}

/*  */
