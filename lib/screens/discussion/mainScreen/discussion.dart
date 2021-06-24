import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/homePage/widgets/publication.dart';



class Discussion extends StatefulWidget {
  @override
  _Discussion createState() => _Discussion();
}

class _Discussion extends  State<Discussion> {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: ElevatedButton(
              onPressed:(){ Navigator.pop(context);},
            ),
          ),
          Cont(), Cont(), Cont(), Cont()],
      ),
    );

  }
}