import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/Notifications/mainScreen/notifPage.dart';
import 'package:my_camp/screens/homePage/widgets/event.dart';
import 'package:my_camp/screens/homePage/widgets/publication.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_camp/screens/profile/widgets/post.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 122,
                  height: 122,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/mekki.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          "Ahmed Mekki ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        margin: EdgeInsets.only(top: 30.0, left: 40),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Container(
                          child: Text(
                              "jeyeb 13.5 fel sem 2 lssd tayer aaaaaaaaaaaaaaaaaa",
                              maxLines: 3,
                              style: TextStyle(fontSize: 15)),
                        ),
                        margin: EdgeInsets.only(
                            top: 10.0, bottom: 16.0, right: 16.0, left: 16.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.071,
                top: MediaQuery.of(context).size.width * 0.071),
          ),
          Container(
            padding:EdgeInsets.only(top:10),
              child: Row(
                children: [
                  Container(
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.blue),
                            primary: Color.fromRGBO(241, 249, 255, 1),
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 40, right: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30)),
                                side: BorderSide(color: Colors.red))),
                        onPressed: () {},
                        child: Text('Edit Picture'),
                      ),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.07)),
                  Container(
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              width: 3,
                              style: BorderStyle.solid,
                              color: Colors.blue),
                          primary: Color.fromRGBO(241, 249, 255, 1),
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 40, right: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                              side: BorderSide(
                                  width: 3,
                                  style: BorderStyle.solid,
                                  color: Colors.blue))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotifPage()));
                      },
                      child: Text('Notifications'),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08)),
          Container(
            child: Text(
              'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.only(top: 10, bottom: 0),
          ),
         Container(child:ElevatedButton(
      onPressed: () {},
      child: Icon(Icons.add, color: Colors.white),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        
        primary: Colors.blue, // <-- Button color
        onPrimary: Colors.red, // <-- Splash color
      ),
    ),
    margin: EdgeInsets.all(10),
    ),
          PostPage(),
          PostPage(),
        ],
      ),
    );
  }
}
