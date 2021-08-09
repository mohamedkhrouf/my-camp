import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_camp/screens/addEventFormPage/widgets/addImage.dart';
import 'package:my_camp/screens/addEventFormPage/widgets/imageContainer.dart';

import '../../homePage/widgets/campSitesList.dart';

class CampSiteForm extends StatefulWidget {
  @override
  _CampSiteForm createState() => _CampSiteForm();
  
}

class _CampSiteForm extends State<CampSiteForm> {
  List chosenImages = [];
  final descriptionController = TextEditingController();
  final usernameController = TextEditingController();
  final villeController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var user;
  DateTime selectedBrithdate = DateTime.now();
  var imagesError = "";
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  List getProfile() {
    var uid = (FirebaseAuth.instance.currentUser).uid;

    print(uid);
    FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
      if (mounted) {
        setState(() {
          user = value;
        });
      }
    });
    return user;
  }

  void deleteImage(int index) {
    setState(() {
      chosenImages.removeAt(index);
    });
  }

  File _image;
  var img;
  final _picker = ImagePicker();

  Future getImage() async {
    final image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
      img = image.path;
      return (image.path);
    });
  }

  DateTime firstDate = DateTime.utc(1998, 11, 9);
  DateTime selectedCampingDate = DateTime.now();
  DateTime selectedPayementDate = DateTime.now();

  bool testCampingDate(selectedDate) {
    DateTime today = DateTime.now();
    return (selectedDate.year == today.year &&
        selectedDate.month == today.month &&
        selectedDate.day == today.day);
  }

  Future<void> _selectCampingDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: firstDate,
        firstDate: firstDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedCampingDate)
      setState(() {
        selectedCampingDate = picked;
      });
    print(selectedCampingDate);
  }

  Future<void> _selectPayementDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: firstDate,
        firstDate: firstDate,
        lastDate: selectedCampingDate);
    if (picked != null && picked != selectedPayementDate)
      setState(() {
        selectedPayementDate = picked;
      });
    print(selectedPayementDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(36, 34, 47, 1),
          title: Center(
              child: Text(
            "Edit Profile",
            style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),
          )),
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0, top: 20),
                child: GestureDetector(
                    onTap: () {
                      if (chosenImages.length == 0)
                        setState(() {
                          imagesError = "Choose at least a picture";
                        });
                      if (_formKey.currentState.validate() &&
                          chosenImages.length > 0) {
                        /* CollectionReference collectionReference =
                            FirebaseFirestore.instance.collection('event');
                        return collectionReference.add({
                          'username': usernameController.text,
                          'description': descriptionController.text,
                          'birthdateDate': selectedCampingDate,
                          'avatar': img,
                          'ville': villeController.text,
                        }).then((value) {
                          descriptionController.clear();
                          usernameController.clear();
                          villeController.clear();
                          Navigator.of(context).pop();
                        }).catchError(
                            (error) => print("Failed to add user: $error")); */
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc((FirebaseAuth.instance.currentUser).uid)
                            .update({
                              'username': usernameController.text,
                              'ville': villeController.text,
                              'description': descriptionController.text,
                              'avatar': img,
                              'phone': phoneController.text,
                            })
                            .then((value) => print("User Updated"))
                            .catchError((error) =>
                                print("Failed to update user: $error"));
                      }
                    },
                    child: Text(
                      "Publish",
                      style: TextStyle(
                        color: Color.fromRGBO(170, 215, 62, 1),
                      ),
                    ))),
          ],
        ),
        body: Container(
          child: Form(
              key: _formKey,
              child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(user != null
                              ? user.data()["avatar"]
                              : "https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg"),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.images,
                          color: Colors.green,
                        ),
                        title: Text("Edit profile avatar"),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text("username:")),
                    Container(
                      margin:
                          EdgeInsets.only(top: 0.0, right: 16.0, left: 16.0),
                      child: Container(
                        margin: EdgeInsets.only(right: 16.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter number of places';
                            }
                            return null;
                          },
                          controller: usernameController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 3, bottom: 3),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text("state:")),
                    Container(
                      margin:
                          EdgeInsets.only(top: 0.0, right: 16.0, left: 16.0),
                      child: Container(
                        margin: EdgeInsets.only(right: 16.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter valid state';
                            }
                            return null;
                          },
                          controller: villeController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 3, bottom: 3),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text("description:")),
                    Container(
                      margin:
                          EdgeInsets.only(top: 0.0, right: 16.0, left: 16.0),
                      child: Container(
                        margin: EdgeInsets.only(right: 16.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter valid description';
                            }
                            return null;
                          },
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 3, bottom: 3),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                          ),
                        ),
                      ),
                    ),
                    (imagesError == "")
                        ? Container()
                        : Text(imagesError,
                            style: TextStyle(color: Colors.red)),
                    GestureDetector(
                        onTap: () {
                          _selectCampingDate(context);
                        },
                        child: ListTile(
                          leading: Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: Colors.red,
                          ),
                          title: Text("Birthdate"),
                        )),
                    testCampingDate(selectedCampingDate)
                        ? Container()
                        : Text("Birthdate : $selectedCampingDate"),
                    Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text("phone:")),
                    Container(
                      margin:
                          EdgeInsets.only(top: 0.0, right: 16.0, left: 16.0),
                      child: Container(
                        margin: EdgeInsets.only(right: 16.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter valid phone number';
                            }
                            return null;
                          },
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 3, bottom: 3),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                          ),
                        ),
                      ),
                    ),
                  ])),
        ));
  }
}

