import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/homePage/widgets/publication.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends  State<HomePage> {


@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [Cont(), Cont(), Cont(), Cont()],
    ),
  );

}
}