import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/myEvents/widgets/event.dart';

class MyEvents extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(90.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
      )
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     child: Column(children: [
      Container(
          child: Form(
              key: _formKey,
              child: Container(
                  margin: EdgeInsets.all(16.0),
                  child:
                    TextFormField(
                      decoration: const InputDecoration(
                      hintText: 'Enter event name',
                      contentPadding: EdgeInsets.only(left: 15.0),
                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.all( Radius.circular(90.0))
                      ),
                      prefixIcon: Icon(Icons.search)

                    )
              )

              )
          ),
       /* decoration: BoxDecoration(

            borderRadius: BorderRadius.all(Radius.circular(90.0)),
            border: Border.all()

        ),*/

      ),
      Group(),
      Group(),
      Group(),
    ]));
  }
}
