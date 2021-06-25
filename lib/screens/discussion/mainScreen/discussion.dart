import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/homePage/widgets/publication.dart';
import 'package:my_camp/screens/tasks/mainScreen/tasks.dart';

class Discussion extends StatefulWidget {
  @override
  _Discussion createState() => _Discussion();
}

class _Discussion extends State<Discussion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Icon(Icons.arrow_back),
                    margin: EdgeInsets.only(right: 20.0),
                  ),
                ),
                Text(
                  "Group name",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tasks()),
                    );
                  },
                  child: Text("Tasks"),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.only(right: 16.0,left:16.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
                )
              ],
            ),
            padding: EdgeInsets.all(16.0),
          )),
      body: SingleChildScrollView(
          child: Column(
              children: [Cont(), Cont(), Cont(), Cont()],
      )),
    );
  }
}
