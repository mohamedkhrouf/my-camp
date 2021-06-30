import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/homePage/widgets/addEventForm.dart';
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
            margin: EdgeInsets.only(top: 30.0, bottom: 16.0),
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
                        )),
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
                        )),
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
                        )),
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
                        )),
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
          !publication
              ? Column(
                  children: [Cont(), Cont(), Cont(), Cont()],
                )
              : Column(children: [
                  Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: Row(children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: AssetImage("assets/mekki.jpg"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    new Flexible(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddEventForm()),
                          );
                        },
                        child: SizedBox(

                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Container(
                            padding: EdgeInsets.only(left: 16.0,top: 4.2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(color: Colors.black)),
                            child: Text(
                              'Add a new event...',
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    )
                  ])),
                  Column(
                    children: [EvPage(), EvPage(), EvPage(), EvPage()],
                  )
                ])
        ],
      ),
    );
  }
}
