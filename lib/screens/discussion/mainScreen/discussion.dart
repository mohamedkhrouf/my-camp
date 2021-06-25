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
    return Scaffold(
        appBar:PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              child:Row(children: [
                  Container(
                    child: ElevatedButton(
                        onPressed:(){ Navigator.pop(context);},
                        child: Icon(Icons.arrow_back),

                    ),

                  ),
                  Text("Group name", style: TextStyle(fontSize: 20),)
              ],
            ),
              padding: EdgeInsets.all(16.0),
            )

        ) ,
        body:SingleChildScrollView(
          child: Column(children: [

            Cont(),
            Cont(),
            Cont(),
            Cont()],
        )),
    );

  }
}