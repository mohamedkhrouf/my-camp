import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notif extends StatefulWidget {
  @override
  _Notif createState() => _Notif();
  final demand;
  final id;
  const Notif({Key key, this.demand, this.id}) : super(key: key);
}

class _Notif extends State<Notif> {
  var user;
  var event ;

  void initState() {
    super.initState();
    getUser();
    print(user);
  }

  getUser()  {
//    CollectionReference collectionReference =FirebaseFirestore.instance.collection('user');
    String uid = widget.demand["userId"].id;
    print(uid);
    FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
      if (mounted) {
        setState(() {
          user = value;
        });
      }
    });
    FirebaseFirestore.instance.collection('event').doc(widget.demand["eventId"].id).get().then((value) {
      if (mounted) {
        setState(() {
          event = value;
        });
      }
    });



  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 16),
      color: Color.fromRGBO(241, 249, 255, 1),
      padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0),
      child: Row(
        children: [
          Container(
            child: Container(
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(user != null
                    ? user.data()["avatar"]
                    : "https://images.squarespace-cdn.com/content/v1/5d9cceda4305a15ce8619c7e/1574894159388-EUV3A0SC8ZZXQXMN7RAL/ke17ZwdGBToddI8pDm48kKPxQF3y6ACiilOwP4hijyt7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UdvLbAfL5pxwrgbwpvOCYZ-gFZWzBm2i02YX3WjdvL58ZDqXZYzu2fuaodM4POSZ4w/grey.png?format=2500w"),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(user!=null?user.data()["username"]:"",
                        style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    child:
                        Text(event!= null ? event.data()["name"]: "", style: TextStyle(fontSize: 15)),
                  ),
                ],
              )),
          Expanded(
              child: Align(
            child: Container(
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('event')
                            .doc(widget.demand["eventId"].id)
                            .update(
                            {
                              'members' :FieldValue
                                  .arrayUnion(
                                    [widget.demand["userId"]]
                                  )
                            }
                            ).then((value) => print(widget.demand["userId"]))
                            .catchError((error) => print("Failed to update event: $error"));
                        FirebaseFirestore.instance.collection('user')
                            .doc(widget.demand["userId"].id)
                            .update(
                            {
                              'events' :FieldValue
                                  .arrayUnion(
                                  [widget.demand["eventId"]]
                              )
                            }
                        ).then((value) => print(widget.demand["eventId"]))
                            .catchError((error) => print("Failed to update user: $error"));
                       FirebaseFirestore.instance.collection('demand').doc(widget.id).delete();
                      },
                      child: Icon(Icons.check_sharp, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10),
                        primary: Colors.blue, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        print("delete");
                        FirebaseFirestore.instance.collection('demand').doc(widget.id).delete();
                      },
                      child: Icon(Icons.clear, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10),
                        primary: Colors.grey, // <-- Button color
                      ),
                    ),
                  ),
                ],
              ),
            ),
            alignment: Alignment.bottomRight,
          ))
        ],
      ),
    );
  }
}
