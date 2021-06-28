import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/discussion/mainScreen/discussion.dart';

class Group extends StatefulWidget {
  final String groupName;

  final String date;

  const Group({Key key, this.groupName, this.date}) : super(key: key);

  @override
  _Group createState() => _Group();
}

class _Group extends State<Group> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Discussion()),
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          margin: EdgeInsets.only(bottom: 30.0),
          child: Row(

            children: [
              Container(
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(widget.groupName,
                              style: TextStyle(fontSize: 20))),
                      Container(
                        child:
                            Text(widget.date, style: TextStyle(fontSize: 15)),

                      ),
                    ],
                  )),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text("Pending..."),
                      alignment: Alignment.bottomRight,
                  )
              )
            ],
          ),
        ));
  }
}
