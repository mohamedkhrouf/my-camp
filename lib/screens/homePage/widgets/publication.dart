import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_camp/screens/homePage/widgets/visitedProfile.dart';

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

  @override
  void initState() {
    super.initState();
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
          .update({'likes':FieldValue.arrayRemove([userId])})
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
                            ? DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(
                            widget.yep["publicationDate"].microsecondsSinceEpoch))
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
          onDoubleTap: (){
            setState(() {
              like();
            });
          },
          child:Stack(
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
                        style:
                            TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                      margin: EdgeInsets.only(top: 2),
                    ),
                  ],
                )),
          ],
        ),),
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
                            setState(() {});
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
