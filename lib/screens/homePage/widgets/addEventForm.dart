import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEventForm extends StatefulWidget {
  @override
  _AddEventForm createState() => _AddEventForm();
}

class _AddEventForm extends State<AddEventForm> {

  var publication = true;
  var event = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),

        )
    );
  }
}