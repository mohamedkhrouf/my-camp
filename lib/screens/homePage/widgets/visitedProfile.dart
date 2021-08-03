import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:my_camp/screens/profile/widgets/post.dart';

class VisitedProfilePage extends StatefulWidget {
  final userId ;

  const VisitedProfilePage({Key key, this.userId}) : super(key: key);
  @override
  _VisitedProfilePageState createState() => _VisitedProfilePageState();
}


class _VisitedProfilePageState extends State<VisitedProfilePage> {
  var user;
  List posts=[];
  @override
  void initState() {
    super.initState();
    getProfile();
    getPosts();
  }

  List getProfile() {
    var uid = widget.userId ;

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

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 34, 47, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(""
          ,
          style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),
        ),
              ),
      body:SingleChildScrollView(
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
            child: Text(
              user != null ? user.data()["description"] : "",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,

              ),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.only(top: 10, bottom: 16),
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
    ) ,);
  }
}