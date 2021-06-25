import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:my_camp/screens/myEvents/widgets/event.dart';

class GroupModel {
  GroupModel({this.groupName, this.date});

  final String groupName;
  final String date;
}

List<GroupModel> allGroups = [
  new GroupModel(groupName: "groupName 1 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "groupName2 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "groupName3 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "hhhhh4 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "gggghhh75 .....", date: "yyyy/mm/dd"),new GroupModel(groupName: "groupName3 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "hhhhh4 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "gggghhh75 .....", date: "yyyy/mm/dd"),new GroupModel(groupName: "groupName3 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "hhhhh4 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "gggghhh75 .....", date: "yyyy/mm/dd"),new GroupModel(groupName: "groupName3 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "hhhhh4 .....", date: "yyyy/mm/dd"),
  new GroupModel(groupName: "gggghhh75 .....", date: "yyyy/mm/dd"),
];
class MyEvents extends StatefulWidget{
  @override
  _MyEvents createState() => _MyEvents();
}
class _MyEvents extends State<MyEvents> {
  var groupList = allGroups;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(90.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(36, 34, 47, 1),
            title :Center(child: Text("My events",style: TextStyle(
              color: Color.fromRGBO(170, 215, 62, 1)
            ),)
            )),
        body: SingleChildScrollView(child:Column(
        children: [
      Container(
        child: Form(
            key: _formKey,
            child: Container(
                margin: EdgeInsets.all(16.0),
                child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Enter event name',
                        contentPadding: EdgeInsets.only(left: 15.0),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0))),
                        prefixIcon: Icon(Icons.search)),
                    onChanged: (text) {
                      print(text);
                      print(groupList.length);
                      setState(() {
                        groupList = allGroups
                            .where((g) => g.groupName.contains(text))
                            .toList();
                      });

                    }))),
      ),
      Container(
      child : ListView.builder(
          shrinkWrap: true,
          itemCount: groupList.length,
          itemBuilder: (context, index) {
            return Group(
                groupName: groupList[index].groupName,
                date: groupList[index].date);
          }
      )
      )
    ])));
  }
}
