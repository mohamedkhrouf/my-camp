import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_camp/screens/tasks/widgets/takeTaskButton.dart';

class Task extends StatefulWidget{
  final String taskName ;
  final userId ;
  final taskId ;
  final taskDone;
  const Task({Key key, this.taskName, this.userId, this.taskId, this.taskDone}) : super(key: key);

  @override
  _Task createState() => _Task();
}
class _Task extends State<Task>{
  var userImage ;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserImage();
  }
  getUserImage(){
     if(widget.userId!=null){
       FirebaseFirestore.instance.collection('user').doc(widget.userId.id).get().then((value)
       {
         if(mounted)
         setState(() {
           userImage=value.data()["avatar"];
         });
       }
       );
     }
  }
  @override
  Widget build(BuildContext context)
  {
    return ListTile(
        leading: Icon(FontAwesomeIcons.tasks),
        title: Row(

            children :[
              Text(widget.taskName),
              Spacer(),
              widget.taskDone? Container(padding: EdgeInsets.only(right: 16.0),child: Icon(FontAwesomeIcons.check)): Container(),
              widget.userId==null ? TakeTaskButton(taskId:widget.taskId): Container(
                margin: EdgeInsets.only(right:8),
                child:CircleAvatar(
                radius: 23.0,
                backgroundImage: NetworkImage(userImage!=null ?userImage: "https://www.coverlambygrespania.com/wp-content/uploads/wp-imk/basic-cov/despiece/78ba-34_coverlam-basic-gris-50x100_rgb.jpg"),
                backgroundColor: Colors.transparent,
              ),),
            ]
        )
    );
  }
}