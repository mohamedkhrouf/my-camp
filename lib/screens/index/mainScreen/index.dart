import 'package:flutter/material.dart';
import 'package:my_camp/screens/Notifications/mainScreen/notifPage.dart';

import 'package:my_camp/screens/homePage/mainScreen/homePage.dart';
import 'package:my_camp/screens/homePage/mainScreen/mapPage.dart';
import 'package:my_camp/screens/myEvents/mainScreen/myEvents.dart';



class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  var tabs = [
    HomePage(),

    MyEvents(),
    NotifPage(),
    Center(
      child: Text("Camp "),
    ),
    Center(
      child: Text("Tasks"),
    ),
    Center(
      child: Text("Profile"),
    )
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromRGBO(170, 215, 62, 1),
              ),
              label: "Home",
              backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
                color: Color.fromRGBO(170, 215, 62, 1),
              ),
              label: "My events",
              backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                color: Color.fromRGBO(170, 215, 62, 1),
              ),
              label: "Camp sites",
              backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                color: Color.fromRGBO(170, 215, 62, 1),
              ),
              label: "My tasks",
              backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Color.fromRGBO(170, 215, 62, 1),
              ),
              label: "Profile",
              backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            )
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}