import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cont extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Color.fromRGBO(170, 215, 62, 1),
            height: MediaQuery.of(context).size.width * 0.2311,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    Icons.person,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: EdgeInsets.all(24),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "name surname",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          margin: EdgeInsets.only(right: 10),
                        ),
                        Container(
                          child: Text(
                            "name surname",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.left,
                          ),
                          margin: EdgeInsets.only(right: 40),
                        ),
                      ],
                    )),
              ],
            )),
        Container(
          color: Colors.blue,
          height: MediaQuery.of(context).size.width * 0.744,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
            color: Color.fromRGBO(255, 255, 255, 1),
            height: MediaQuery.of(context).size.width * 0.2752,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Container(child:
                Row(
                  children: [
                   Container(child:
                    Icon(
                      Icons.favorite,
                      color: Color.fromRGBO(2, 255, 255, 1),

                    ),
                    margin:EdgeInsets.only(right:20)),
                    Container(child:
                    Icon(
                      Icons.add_comment,
                      color: Color.fromRGBO(2, 255, 255, 1),
                    ),)
                  ],
                ),
                margin: EdgeInsets.only(left: 10,top:10),
                ),
                Column(
                  children: [
                     Container(
                          child: Text(
                            "name surname lorem ipsum lorem ipsum lorem ipsum lorem lorem  ipsum lorem",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          margin: EdgeInsets.only(left: 10),
                        ),
                  ],
                )
              ],
            ))
      ],
    );
  }
}
