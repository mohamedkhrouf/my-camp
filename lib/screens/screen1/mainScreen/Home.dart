import 'package:flutter/material.dart';

class Cont extends StatelessWidget {
  Container x;

  Cont()
      : x = Container(
          color: Colors.blue,
          height: 200.0,
          width: 300.0,
          margin: EdgeInsets.all(16),
          child: Text("Hello"),
        );

  @override
  Widget build(BuildContext context) {
    x = Container(
      color: Colors.blue,
      height: 200.0,
      width: 300.0,
      margin: EdgeInsets.all(16),
      child: Text("Hello"),
    );
    return x;
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var container = Container(
    color: Colors.blue,
    height: 200.0,
    width: double.infinity,
    margin: EdgeInsets.all(16),
    child: Text("Hello"),
  );
  var tabs = [
    SingleChildScrollView(
      child: Column(
        children: [Cont(), Cont(), Cont(), Cont()],
      ),
    ),
    Center(
      child: Text("Groups"),
    ),
    Center(
      child: Text("Camp sites"),
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
                color: Color.fromRGBO(170,215,62,1),
              ),
              label: "Home",
              backgroundColor: Color.fromRGBO(36,34,47,1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
                color: Color.fromRGBO(170,215,62,1),
              ),
              label: "My events",
              backgroundColor: Color.fromRGBO(36,34,47,1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                color: Color.fromRGBO(170,215,62,1),
              ),
              label: "Camp sites",
              backgroundColor: Color.fromRGBO(36,34,47,1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                color: Color.fromRGBO(170,215,62,1),
              ),
              label: "My tasks",
              backgroundColor: Color.fromRGBO(36,34,47,1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Color.fromRGBO(170,215,62,1),
              ),
              label: "Profile",
              backgroundColor: Color.fromRGBO(36,34,47,1),
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
