import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/myEvents/widgets/event.dart';
/*
class GroupModel {
  GroupModel({this.groupName, this.date});

  final String groupName;
  final String date;
}

List<GroupModel> allGroups = [
  new GroupModel(groupName: "groupName 1 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "groupName2 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "groupName3 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "hhhhh4 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "gggghhh75 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "groupName3 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "hhhhh4 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "gggghhh75 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "groupName3 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "hhhhh4 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "gggghhh75 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "groupName3 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "hhhhh4 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "gggghhh75 .....", date: "yyyy/mm/dd"),
];*/

class MyEvents extends StatefulWidget {
  @override
  _MyEvents createState() => _MyEvents();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class _MyEvents extends State<MyEvents> {
  List myEvents = [];

  var shownEventList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(90.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ));

  @override
  initState() {
    super.initState();
    getMyEvents();
  }

  void asyncMethod() async {
    //Duration duration = new Duration(seconds: 3);
    //sleep(duration);
  }

  /*Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'username': "fullName", // John Doe
      'birthdate': "company", // Stokes and Sons
      'gender': "age" ,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
*/
  getMyEvents() {
//    CollectionReference collectionReference =FirebaseFirestore.instance.collection('user');
    String userId = (FirebaseAuth.instance.currentUser).uid;
    print(userId);
    FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .get()
        .then((value) {

      for (int i = 0; i < value["events"].length; i++) {
        value["events"][i].get().then((value) {

          setState(() {
            myEvents.add(value);
          });
        });
      }
    }).then((value) =>      shownEventList = myEvents);
    print(myEvents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            title: Center(
                child: Text(
              "My events",
              style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),
            ))),
        body: (myEvents.length==0 && shownEventList.length==0)?
        Center(child: Text("No events for the moment"),)
            :
        SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              Container(
                child: Form(
                    key: _formKey,
                    child: Container(
                        margin: EdgeInsets.all(16.0),
                        child: TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Enter event name',
                                contentPadding: EdgeInsets.only(left: 15.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(90.0))),
                                prefixIcon: Icon(Icons.search)),
                            onChanged: (text) {
                              print(text);
                              print(shownEventList);
                              setState(() {
                                shownEventList = myEvents
                                    .where(
                                        (e) => e.data()["name"].contains(text))
                                    .toList();
                              });
                            }))),
              ),
              ...shownEventList.map((e) {
                return Group(
                  groupName: e.data()["name"],
                  date: DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(
                      e.data()["startingDate"].microsecondsSinceEpoch))
                      .toString(),
                  eventId: e.id,
                  groupImage : e.data()["images"][0],
                  pendingUsers: e.data()["pendingUsers"],
                );
              }),
              /* Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: groupList.length,
                  itemBuilder: (context, index) {
                    return Group(
                        groupName: groupList[index].groupName,
                        date: groupList[index].date);
                  }))*/
            ])));
  }
}
