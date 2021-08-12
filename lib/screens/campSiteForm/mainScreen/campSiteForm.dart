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
   final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(36, 34, 47, 1),
          title: Center(
              child: Text(
            "Add camping place",
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
                  
                      if (_formKey.currentState.validate()) {
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
                            .collection('place')
                           
                            .add({
                              'name': usernameController.text,
                              'address': villeController.text,
                              'description': descriptionController.text,
                              'longitude': longitudeController.text,
                              'latitude': latitudeController.text,
                              'pending': true
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
                      margin: EdgeInsets.only(top: 60,left:16.0),
                      child: Text(
                        user!=null?"Hello ${user.data()["username"]}":"Hello",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    Container(
                         margin: EdgeInsets.only(left:16.0),
                      child: Text(
                        "Let's create a new camp place",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text("name:")),
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
                        child: Text("address:")),
                    Container(
                      margin:
                          EdgeInsets.only(top: 0.0, right: 16.0, left: 16.0),
                      child: Container(
                        margin: EdgeInsets.only(right: 16.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter valid address';
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
                   ListTile(
                          leading: Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Colors.red,
                          ),
                          title: Text("Choose position:"),
                        ),
                         Container(
                      margin: EdgeInsets.only(left:16.0,right: 16.0, bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Flexible(
                            child: Container(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: latitudeController,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'Enter latitude';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Latitude',
                                  contentPadding: EdgeInsets.only(
                                      left: 15.0, top: 3, bottom: 3),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0))),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: longitudeController,
                              validator: (value) {
                                if (value.length == 0) {
                                  return 'Enter longitude';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Longitude',
                                contentPadding: EdgeInsets.only(
                                    left: 15.0, top: 3, bottom: 3),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
        ));
  }
}
