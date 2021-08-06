import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/Notifications/mainScreen/notifPage.dart';
import 'package:my_camp/screens/editProfile/mainScreen/editProfilePage.dart';
import 'package:my_camp/screens/postImage/mainScreen/postImage.dart';

import 'package:my_camp/screens/profile/widgets/post.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var user;
  List posts=[];
  @override
  void initState() {
    super.initState();
    getProfile();
    getPosts();
    print(posts);
  }

  List getProfile() {
    var uid = (FirebaseAuth.instance.currentUser).uid;

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

  List getPosts() {
    List documents;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('post');

    collectionReference.snapshots().listen((snapshot) {
      if (mounted) {
        setState(() {
          posts = snapshot.docs;
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
            child: Row(
              children: [
                Spacer(),
                Container(
                  child: CircleAvatar(
                    radius: 60.0,
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
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          user != null ? user.data()["username"] : "",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Container(
                          child: Text(user != null ? user.data()["ville"] : "",
                              maxLines: 3, style: TextStyle(fontSize: 15)),
                        ),
                      ),
                      Container(
                        child: Container(
                          child: Text(
                              user != null ? user.data()["birthday"] : "",
                              maxLines: 3,
                              style: TextStyle(fontSize: 15)),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.071,
                top: MediaQuery.of(context).size.width * 0.071),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Wrap(
              children: [
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(
                            width: 3,
                            style: BorderStyle.solid,
                            color: Colors.blue),
                        primary: Color.fromRGBO(241, 249, 255, 1),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 40, right: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            side: BorderSide(color: Colors.red))),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EditProfilePage()));
                    },
                    child: Text('Edit Profile'),
                  ),
                ),
                Spacer(),
                Container(
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(
                            width: 3,
                            style: BorderStyle.solid,
                            color: Colors.blue),
                        primary: Color.fromRGBO(241, 249, 255, 1),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 40, right: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                            side: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.blue))),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NotifPage()));
                    },
                    child: Text('Notifications'),
                  ),
                ),
                Spacer()
              ],
            ),
          ),
          Container(
            child: Text(
              user != null ? user.data()["description"] : "",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.only(top: 10, bottom: 0),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostImage(user: user)));
              },
              child: Icon(Icons.add, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),

                primary: Colors.blue, // <-- Button color
                onPrimary: Colors.red, // <-- Splash color
              ),
            ),
            margin: EdgeInsets.all(10),
          ),
        ...posts.map((item) {
            if (item.data()["userId"] != null) {
              if (item.data()["userId"].id ==
                  (((FirebaseAuth.instance.currentUser).uid))) {
                return new PostPage(yep: item.data(),id: item.id);
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          }).toList(),
        ],
      ),
    );
  }
}
