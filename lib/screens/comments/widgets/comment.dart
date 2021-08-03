import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_camp/screens/discussion/mainScreen/discussion.dart';

class Comment extends StatefulWidget {
  const Comment({Key key}) : super(key: key);

  @override
  _Comment createState() => _Comment();
}

class _Comment extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 14.0, right: 14.0),
           
            child: Column(children: [Row(
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Danny_DeVito_by_Gage_Skidmore.jpg/1200px-Danny_DeVito_by_Gage_Skidmore.jpg"),
                  
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text("username",
                                style: TextStyle(fontSize: 20))),
                        Container(
                          child:
                              Text("date", style: TextStyle(fontSize: 15)),
                        ),
                      ],
                    ),

                    ),
              ],
            ),
           Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      
                      child: Text(
                        "Should be left jvjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj",
                      ),
                    ),
                  ),
            
Row(
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                             
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.fire,
                            color: true
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


            
            ],)
          ),
          
        ],
          
      ),
    );
  }
}
