import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:my_camp/screens/Notifications/widgets/notif.dart';


class NotifPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(90.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
      )
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
              child:Row(children: [
                  Container(
                    child: OutlinedButton(
                        onPressed:(){ Navigator.pop(context);},
                        child: Icon(Icons.arrow_back),
                       style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Colors.white),)
                    ),

                  ),
                 
              ],
            ),
              padding: EdgeInsets.all(0),
            )

        ) ,
      body: 
   SingleChildScrollView(
     child: Column(children: [
     
      Notif(),
      Notif(),
      Notif(),
    ]))
      
    );
  }
}
