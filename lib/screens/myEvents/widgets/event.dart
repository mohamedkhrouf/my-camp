import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/discussion/mainScreen/discussion.dart';

class Group extends StatelessWidget {
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
          padding: EdgeInsets.all(16.0),
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
                    children: [
                      Container(
                          child: Text("esm l groupe",
                              style: TextStyle(fontSize: 20))),
                      Container(
                          child: Text("yyyy/mm/dd",
                          style: TextStyle(fontSize: 15)
                          ),
                          margin: EdgeInsets.only(right: 30.0) ,
                      ),
                    ],
                  )),
              Expanded(
                  child: Align(
                child: Text("Pending..."),
                alignment: Alignment.bottomRight,
              ))
            ],
          ),
        ));
  }
}
