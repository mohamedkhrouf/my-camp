import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/homePage/widgets/event.dart';
import 'package:my_camp/screens/homePage/widgets/publication.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var publication = true;
  var event = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 70.0, bottom: 30.0),
            child: (publication || event)
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    OutlinedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: 15, bottom: 15, left: 30, right: 30)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    side: BorderSide(color: Colors.red))),
                      ),
                      onPressed: () {
                        setState(() {
                          publication = false;
                          event = false;
                        });
                      },
                      child: Text('Publications'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: 15, bottom: 15, left: 50, right: 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                    side: BorderSide(color: Colors.red))),
                      ),
                      onPressed: () => {
                        setState(() {
                          publication = true;
                          event = true;
                        })
                      },
                      child: Text('Events'),
                    ),
                  ])
                : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: 15, bottom: 15, left: 30, right: 30)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30)),
                                    side: BorderSide(color: Colors.red))),
                      ),
                      onPressed: () => {
                        setState(() {
                          publication = false;
                          event = false;
                        })
                      },
                      child: Text('Publications'),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: 15, bottom: 15, left: 50, right: 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                    side: BorderSide(color: Colors.red))),
                      ),
                      onPressed: () {
                        setState(() {
                          publication = true;
                          event = false;
                        });
                      },
                      child: Text('Events'),
                    ),
                  ]),
          ),
          !publication?Column(children: [
            Cont(),
          Cont(),
          Cont(),
          Cont()
          ],):
          Column(children: [
            EvPage(),
          EvPage(),
          EvPage(),
          EvPage()
          ],)
         
        ],
      ),
    );
  }
}
