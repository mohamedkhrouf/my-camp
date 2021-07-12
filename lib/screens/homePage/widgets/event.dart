import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/homePage/mainScreen/mapPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EvPage extends StatefulWidget {
  @override
  _EvPageState createState() => _EvPageState();
  final data;
  const EvPage({Key key, this.data}) : super(key: key);
}

class _EvPageState extends State<EvPage> {
  var clicked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Color.fromRGBO(188, 224, 253, 1),
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Spacer(),
                Container(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("assets/mekki.jpg"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Spacer(),
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        widget.data["name"],
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Container(
                      child: Text(
                        DateTime.fromMicrosecondsSinceEpoch(
                                widget.data["publicationDate"].seconds *
                                    1000002)
                            .toString(),
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(right: 40),
                    ),
                  ],
                )),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
                Spacer(),
              ],
            )),
        Container(
            child: Stack(
          children: [
            Image.network(
              widget.data["images"][0],
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              bottom: 20,
              left: 60,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(color: Colors.brown),
                            primary: Colors.white,
                            padding: !clicked
                                ? EdgeInsets.only(
                                    top: 15, bottom: 15, left: 50, right: 50)
                                : EdgeInsets.only(
                                    top: 15,
                                    bottom: 15,
                                    left: 32.5,
                                    right: 32.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                            )),
                        onPressed: () {
                          setState(() {
                            clicked = !clicked;
                          });
                        },
                        child: !clicked ? Text('Join') : Text('pending...'),
                      ),
                      margin: EdgeInsets.only(right: 20),
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                              top: 15, bottom: 15, left: 50, right: 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          )),
                        ),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapPage()))
                        },
                        child: Text('Map'),
                      ),
                      margin: EdgeInsets.only(left: 20),
                    )
                  ]),
            ),
          ],
        )),
        Container(
            color: Color.fromRGBO(255, 255, 255, 1),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: Icon(
                            FontAwesomeIcons.fire,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                          margin: EdgeInsets.only(right: 20)),
                      Container(
                        child: Icon(
                          FontAwesomeIcons.commentDots,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 10, top: 10),
                ),
                Container(
                  child: Text(
                    widget.data["description"],
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  margin: EdgeInsets.only(left: 10, right: 10),
                ),
              ],
            ))
      ],
    );
  }
}
