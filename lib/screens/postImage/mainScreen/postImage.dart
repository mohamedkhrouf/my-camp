import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_camp/screens/campSitePage/mainScreen/campSitePage.dart';

class PostImage extends StatefulWidget {
  @override
  _PostImageState createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
              child: Row(
                children: [
                  Container(
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back),
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                        )),
                  ),
                  Container(
                      child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ))
                ],
              ),
              padding: EdgeInsets.all(0),
            )),
        body: SingleChildScrollView(
            child: Column(children: [
          Row(
            children: [
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 20, top:40),
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.grey),
                      primary: Colors.white,
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Spacer()
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom:10),
            width: MediaQuery.of(context).size.width,
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Add captions',
                contentPadding: EdgeInsets.only(left: 15.0, top: 3, bottom: 3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width * 0.25,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                  primary: Colors.white,
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  )),
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CampSitePage()));
                });
              },
              child: Container(
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      "Lieux",
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      color: Colors.blue,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                  primary: Colors.blue,
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  )),
              onPressed: () {
                setState(() {});
              },
              child: Container(
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
          ),
        ])));
  }
}