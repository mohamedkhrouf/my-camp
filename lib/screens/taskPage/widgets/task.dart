import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final data;
  final id;

  const Task({Key key, this.data, this.id}) : super(key: key);

  @override
  _Task createState() => _Task();
}

class _Task extends State<Task> {
  var event;
  @override
  void initState() {
    super.initState();
    getEvent();
  }

  checked() {
    return widget.data["checked"];
  }

  getEvent() {
//    CollectionReference collectionReference =FirebaseFirestore.instance.collection('user');
    String uid = widget.data["eventId"].id;
    print(widget.data["eventId"].id);
    print(uid);
    FirebaseFirestore.instance.collection('event').doc(uid).get().then((value) {
      if (mounted) {
        setState(() {
          event = value;
        });
      }
    });
    return event;
  }

  Future<void> check() {
    if (widget.data["checked"]) {
      FirebaseFirestore.instance
          .collection('task')
          .doc(widget.id)
          .update({'checked': !widget.data["checked"]})
          .then((value) => print("Task Updated"))
          .catchError((error) => print("Failed to update Task: $error"));
    } else {
      FirebaseFirestore.instance
          .collection('task')
          .doc(widget.id)
          .update({'checked': !widget.data["checked"]})
          .then((value) => print("Task Updated"))
          .catchError((error) => print("Failed to update task: $error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.0),

      child:ListTile(

        leading: Container(
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(event != null
                ? event.data()["images"][0]
                : "https://images.squarespace-cdn.com/content/v1/5d9cceda4305a15ce8619c7e/1574894159388-EUV3A0SC8ZZXQXMN7RAL/ke17ZwdGBToddI8pDm48kKPxQF3y6ACiilOwP4hijyt7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UdvLbAfL5pxwrgbwpvOCYZ-gFZWzBm2i02YX3WjdvL58ZDqXZYzu2fuaodM4POSZ4w/grey.png?format=2500w"),
            backgroundColor: Colors.transparent,
          ),
        ),
        title: Row(children: [
          Text(widget.data["name"]),
          Spacer(),
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: checked(),
            onChanged: (bool value) {
              setState(() {
                check();
              });
            },
          ),
        ])) ,);
  }
}
