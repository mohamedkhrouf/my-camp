import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_camp/screens/comments/mainScreen/postComment.dart';
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
  @override
  void initState() {
    super.initState();

    widget.yep["images"].forEach((e) {
      items.add(e.toString());
      print(e.toString());
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
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostComment(yep: widget.yep
                                    ,id:widget.id)));
                          
                          },
                        ),
                      )
                      
                    ]),
                    margin: EdgeInsets.only(left: 10, top: 10),
                  ),
                  Container(
                    child: Text(
                      "name surname lorem ipsum lorem ipsum lorem ipsum lorem lorem  ipsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaum lorem",
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
