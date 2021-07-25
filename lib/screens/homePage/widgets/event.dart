import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/homePage/mainScreen/mapPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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

    @override
  void initState() {
    super.initState();
    getUser();
  }
  getUser() {
//    CollectionReference collectionReference =FirebaseFirestore.instance.collection('user');
    String uid = widget.yep["adminId"].id;
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
            margin: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Spacer(),
                Container(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(user!=null?user.data()["avatar"]:"https://images.squarespace-cdn.com/content/v1/5d9cceda4305a15ce8619c7e/1574894159388-EUV3A0SC8ZZXQXMN7RAL/ke17ZwdGBToddI8pDm48kKPxQF3y6ACiilOwP4hijyt7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UdvLbAfL5pxwrgbwpvOCYZ-gFZWzBm2i02YX3WjdvL58ZDqXZYzu2fuaodM4POSZ4w/grey.png?format=2500w"),
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
                      child: Text(
                        user!=null ?  user.data()["username"]: "",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Container(
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(
                            widget.yep["publicationDate"].microsecondsSinceEpoch))
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
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(color: Colors.brown),
                            primary: Colors.white,
                            padding: !clicked
                                ? EdgeInsets.only(
                                    top: 15, bottom: 15, left: 50, right: 50)
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
                            FirebaseFirestore.instance.collection('demand').add(
                              {
                                  'eventId': widget.yep,
                                  'userId' : FirebaseFirestore.instance.doc("user/"+(FirebaseAuth.instance.currentUser).uid),
                                  'state': "pending",
                                  'receiverId': FirebaseFirestore.instance.doc("user/"+user.id)
                              }
                            );
                          });
                        },
                        child: !clicked ? Text('Join') : Text('pending...'),
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
                                  builder: (context) => MapPage()))
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
            margin: EdgeInsets.only(left: 10, top: 10,bottom: 16),

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
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Text("Event Name: "+widget.yep["name"],style: TextStyle(fontSize: 20),),
                Container(
                  child: Text(
                    widget.yep["description"],
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            )
        )
      ],
    );
  }
}
