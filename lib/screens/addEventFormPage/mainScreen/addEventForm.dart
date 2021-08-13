import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_camp/screens/addEventFormPage/widgets/addImage.dart';
import 'package:my_camp/screens/addEventFormPage/widgets/imageContainer.dart';
import 'package:my_camp/screens/addEventFormPage/widgets/positionsList.dart';
import 'package:my_camp/screens/loading/mainScreen/loading.dart';


class AddEventForm extends StatefulWidget {
  final user;

  const AddEventForm({Key key, this.user}) : super(key: key);
  @override
  _AddEventForm createState() => _AddEventForm();
}

class _AddEventForm extends State<AddEventForm> {
  var loading= false ;
  List chosenImages = [];
  final descriptionController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final nbPlaceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var username = "";
  var imagesError = "";
  var position ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = widget.user.data()["username"];
  }

  Future uploadImageToFirebase(BuildContext context) async {
    List chosenImagesUrl = [];

    var image;
    FirebaseStorage storage = FirebaseStorage.instance;

    for (File image in chosenImages) {
      Reference ref = storage.ref().child("$image" +"_"+ DateTime.now().toString()+"_"+(FirebaseAuth.instance.currentUser).uid);
      TaskSnapshot uploadTask =await ref.putFile(image);
      var imgUrl = await uploadTask.ref.getDownloadURL();
      chosenImagesUrl.add(imgUrl);
    }
    print(chosenImagesUrl);
    return chosenImagesUrl;

  }
  void getPosition(pos){
    setState(() {
      position=pos ;
    });
  }
  void deleteImage(int index) {
    setState(() {
      chosenImages.removeAt(index);
    });
  }

  File _image;

  final _picker = ImagePicker();

  Future getImage() async {
    final image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);

      chosenImages.add(_image

          //ImageContainer(imagePath: _image.path,index: chosenImages.length,deleteImage: deleteImage,          )
          );
    });
  }

  DateTime firstDate = DateTime.now();
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
    return loading ? Loading() :Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(36, 34, 47, 1),
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0, top: 20),
                child: GestureDetector(
                    onTap: () async {
                      if (chosenImages.length == 0)
                        setState(() {
                          imagesError = "Choose at least a picture";

                        });
                      if(_formKey.currentState.validate())
                      {
                            setState(() {
                              loading=true ;
                            });
                            uploadImageToFirebase(context).then((value) {
                              print(value);
                              CollectionReference collectionReference =
                                  FirebaseFirestore.instance
                                      .collection('event');
                              collectionReference.add({
                                'name': 'camping by',
                                'position' : position,
                                'description': descriptionController.text,
                                'latitude': latitudeController.text,
                                'longitude': longitudeController.text,
                                'nbPart': nbPlaceController.text,
                                'startingDate': selectedCampingDate,
                                'dueDate': selectedPayementDate,
                                'publicationDate': DateTime.now(),
                                'images': value,
                                'likes': [],
                                'pendingUsers': [],
                                'members': [
                                  FirebaseFirestore.instance.doc("user/" +
                                      (FirebaseAuth.instance.currentUser).uid)
                                ],
                                'adminId': FirebaseFirestore.instance.doc(
                                    "user/" +
                                        (FirebaseAuth.instance.currentUser)
                                            .uid),
                                'tasks': [],
                              }).then((value) {
                                FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .update({
                                  'events': FieldValue.arrayUnion([value])
                                })
                                    .then((value) => print("User Updated"))
                                    .catchError((error) => print("Failed to update user: $error"));
                                descriptionController.clear();
                                latitudeController.clear();
                                longitudeController.clear();
                                nbPlaceController.clear();
                                Navigator.of(context).pop();
                              }).catchError((error) {
                                setState(() {
                                  loading = false;
                                });
                                }
                                );

                            });
                          }
                        },
                    child: Text(
                      "Publish",
                      style: TextStyle(
                        color: Color.fromRGBO(170, 215, 62, 1),
                        fontSize: 16.0
                      ),
                    ))),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(left: 16.0),
          child: Form(
              key: _formKey,
              child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Hello ${username}",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Let's create a new camping event",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 16.0, right: 16.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Enter description';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter event Description',
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 3, bottom: 3),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16.0))),
                          ),
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                        )),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.images,
                        color: Colors.green,
                      ),
                      title: Text("Choose an image"),
                    ),
                    Container(
                      child: Wrap(
                        spacing: 4.0,
                        children: [
                          (chosenImages.length < 6)
                              ? GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: AddImage(),
                                )
                              : Container(),
                          ...chosenImages.asMap().entries.map((e) {
                            return ImageContainer(
                              imagePath: e.value,
                              index: e.key,
                              deleteImage: deleteImage,
                            );
                          }),
                        ],
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
                          title: Text("Camping date"),
                        )),
                    testCampingDate(selectedCampingDate)
                        ? Container()
                        : Text("Camping Date : $selectedCampingDate"),
                    GestureDetector(
                        onTap: () {
                          _selectPayementDate(context);
                        },
                        child: ListTile(
                          leading: Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: Colors.red,
                          ),
                          title: Text("Payement deadline"),
                        )),
                    testCampingDate(selectedPayementDate)
                        ? Container()
                        : Text("Payement Date : $selectedPayementDate"),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PositionsList(getPosition: getPosition,)),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Colors.red,
                          ),
                          title: Text("Choose position"),
                        )),
                    position == null
                        ? Container()
                        : Container(margin : EdgeInsets.only(left: 16.0,bottom: 16.0),child :Text("Chosen place : "+ position['name'])),

                    Container(
                      margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
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
                    Container(
                      margin: EdgeInsets.only(right: 16.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: nbPlaceController,
                        validator: (value) {
                          if (value.length == 0) {
                            return 'Enter number of places';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Number of places',
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 3, bottom: 3),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                        ),
                      ),
                    ),
                  ])),
        ));
  }
}
