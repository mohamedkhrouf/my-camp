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
        child: Container(child:Stack(children: [
          Container(
            
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            margin: EdgeInsets.only(bottom: 30.0),
            child: Row(

              children: [
                 Container(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("assets/mekki.jpg"),
                    backgroundColor: Colors.transparent,
                  ),
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

              ],
            ),
            
          ),
          Positioned(
              right: 10,
              bottom: 20,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Text("Pending..."),
               
              )
          )
        ],),
        
        ),
        
        );
  }
}
