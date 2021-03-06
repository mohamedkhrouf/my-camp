
import 'package:flutter/material.dart';
import 'package:my_camp/screens/campSites/mainScreen/campSites.dart';

import 'package:my_camp/screens/homePage/mainScreen/homePage.dart';

import 'package:my_camp/screens/myEvents/mainScreen/myEvents.dart';

import 'package:my_camp/screens/profile/mainScreen/profilePage.dart';

import 'package:my_camp/screens/taskPage/mainScreen/taskPage.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  var tabs = [
    HomePage(),
    MyEvents(),
    CampSites(),
    TaskPage(),
    ProfilePage(),
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
                FontAwesomeIcons.campground,
                color: Color.fromRGBO(170, 215, 62, 1),
              ),
              label: "Home",
              backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.peopleCarry,
                color: Color.fromRGBO(170, 215, 62, 1),
              ),
              label: "My events",
              backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.binoculars,
                color: Color.fromRGBO(170, 215, 62, 1),
              ),
              label: "Camp sites",
              backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.tasks,
                color: Color.fromRGBO(170, 215, 62, 1),
              ),
              label: "My tasks",
              backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.hiking,
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
