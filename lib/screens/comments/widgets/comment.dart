import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Comment extends StatefulWidget {
  final comment;
  final eventId;
  const Comment({Key key, this.comment, this.eventId}) : super(key: key);

  @override
  _Comment createState() => _Comment();
}

class _Comment extends State<Comment> {
  var liked = true;
  var comment;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    liked = lik();
    getComment();
  }

  var user;
  nblikes() {
    return widget.comment.data()["likes"].length;
  }

  lik() {
    if (widget.comment
        .data()["likes"]
        .toString()
        .contains((FirebaseAuth.instance.currentUser).uid)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> like() {
    String userId = (FirebaseAuth.instance.currentUser).uid;
    getComment();
    if (comment
        .data()["likes"]
        .toString()
        .contains((FirebaseAuth.instance.currentUser).uid)) {
      FirebaseFirestore.instance
          .collection("event")
          .doc(widget.eventId)
          .collection('comments')
          .doc(widget.comment.id)
          .update({
            'likes': FieldValue.arrayRemove([userId])
          })
          .then((value) => print("comment Updated"))
          .catchError((error) => print("Failed to update comment: $error"));
      setState(() {
        liked = false;
      });
    } else {
      FirebaseFirestore.instance
          .collection("event")
          .doc(widget.eventId)
          .collection('comments')
          .doc(widget.comment.id)
          .update({
            'likes': FieldValue.arrayUnion([userId])
          })
          .then((value) => print("comment Updat"))
          .catchError((error) => print("Failed to update comment: $error"));
      setState(() {
        liked = true;
      });
    }
  }

  getComment() {
    FirebaseFirestore.instance
        .collection("event")
        .doc(widget.eventId)
        .collection('comments')
        .doc(widget.comment.id)
        .get()
        .then((value) {
      if (mounted)
        setState(() {
          comment = value;
        });
    });
  }

  void getUser() {
    FirebaseFirestore.instance
        .collection("user")
        .doc(widget.comment.data()["userId"].id)
        .get()
        .then((value) {
      if (mounted)
        setState(() {
          user = value.data();
        });
    });
  }

  var text = new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: new TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        new TextSpan(
            text: 'username:',
            style: new TextStyle(fontWeight: FontWeight.bold)),
        new TextSpan(text: "mm"),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 14.0, right: 14.0),
              child: Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(user != null
                          ? user["avatar"]
                          : "https://www.waterair.com/sites/default/files/styles/slider/public/2020-03/gris-souris.jpg"),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: RichText(
                              text: new TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: user != null
                                          ? user["username"] + ": "
                                          : "",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  new TextSpan(
                                      text: widget.comment.data()["text"]),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                  Spacer(),
                  Spacer(),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        like();
                      },
                      child: Icon(
                        FontAwesomeIcons.fire,
                        color: liked
                            ? Color.fromRGBO(207, 53, 46, 1)
                            : Color.fromRGBO(0, 0, 0, 1),
                        size: 27,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 10));
  }
}
