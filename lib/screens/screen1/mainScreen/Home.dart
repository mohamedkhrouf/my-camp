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
      appBar: AppBar(
        title: Text("hello l fou9"),
        backgroundColor: Color.fromRGBO(50, 60, 70, 1),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Color.fromRGBO(50, 60, 70, 1),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: "My events",
                backgroundColor: Colors.white24),
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: "Camp sites",
                backgroundColor: Colors.white24),
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: "My tasks",
                backgroundColor: Colors.white24),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
                backgroundColor: Colors.white24)
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
