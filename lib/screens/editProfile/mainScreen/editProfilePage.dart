import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_camp/screens/loading/mainScreen/loading.dart';
import 'package:intl/intl.dart';


class EditProfilePage extends StatefulWidget {
  final user ;

  const EditProfilePage({Key key, this.user}) : super(key: key);
  @override
  _EditProfilePage createState() => _EditProfilePage();

}

class _EditProfilePage extends State<EditProfilePage> {
  var loading= false ;
  var imageChanged = false ;
  var chosenImage = null ;
  var chosenImageUrl = "";
  final descriptionController = TextEditingController();
  final usernameController = TextEditingController();
  final villeController = TextEditingController();
  final phoneController = TextEditingController();
  var birthday = "";
  final _formKey = GlobalKey<FormState>();
  var user;
  DateTime selectedBrithdate = DateTime.now();
  var imagesError = "";
  @override
  void initState() {
    super.initState();
    usernameController.text = widget.user.data()["username"];
    phoneController.text = widget.user.data()["phone"];
    villeController.text = widget.user.data()["ville"];
    birthday = widget.user.data()["birthday"];
    descriptionController.text = widget.user.data()["description"];
    chosenImage= widget.user.data()["avatar"];
  }

  Future uploadImageToFirebase(BuildContext context) async {

    FirebaseStorage storage = FirebaseStorage.instance;

      Reference ref = storage.ref().child("$chosenImage" + DateTime.now().toString());
      TaskSnapshot uploadTask =await ref.putFile(chosenImage);
      var imgUrl = await uploadTask.ref.getDownloadURL();
      chosenImageUrl= imgUrl;

    return chosenImageUrl;

  }


  var img;
  final _picker = ImagePicker();

  Future getImage() async {
    final image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      chosenImage = File(image.path);
      imageChanged=true ;
    });
  }

  DateTime firstDate = DateTime.now();


  bool testCampingDate(selectedDate) {
    DateTime today = DateTime.now();
    return (selectedDate.year == today.year &&
        selectedDate.month == today.month &&
        selectedDate.day == today.day);
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: firstDate,
        firstDate: DateTime(1980),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {

        birthday = DateFormat('dd/MM/yyyy')
            .format(DateTime.fromMicrosecondsSinceEpoch(picked.microsecondsSinceEpoch))
            .toString();

      });
  }



  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(36, 34, 47, 1),
          title:
          Text(
            "Edit Profile",
            style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),
          ),
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

                      if (_formKey.currentState.validate() ) {
                        setState(() {
                          loading = true ;
                        });
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
                        if(imageChanged)
                          uploadImageToFirebase(context).then((value) {
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc((FirebaseAuth.instance.currentUser).uid)
                                .update({
                              'username': usernameController.text,
                              'ville': villeController.text,
                              'description': descriptionController.text,
                              'avatar': value,
                              'phone': phoneController.text,
                              'birthday' : birthday
                            })
                                .then((value) => Navigator.of(context).pop())
                                .catchError((error) {                                  setState(() {
                              loading= false ;
                            });
                            });
                          });
                        else
                          {
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc((FirebaseAuth.instance.currentUser).uid)
                                .update({
                              'username': usernameController.text,
                              'ville': villeController.text,
                              'description': descriptionController.text,
                              'phone': phoneController.text,
                              'birthday' : birthday
                            })
                                .then((value) =>                                Navigator.of(context).pop()
                            )
                                .catchError((error) {
                                  setState(() {
                                    loading= false ;
                                  });
                            });
                          }

                      }
                    },
                    child: Text(
                      "Update",
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
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image:chosenImage is File ?
                            FileImage(
                            chosenImage):
                            NetworkImage(chosenImage != null
                              ? chosenImage
                              : "https://media.tarkett-image.com/large/TH_24567080_24594080_24596080_24601080_24563080_24565080_24588080_001.jpg")


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
                        child: Text("Username:",style: TextStyle(fontSize: 18.0),)),
                    Container(
                      margin:
                          EdgeInsets.only(top: 3.0, right: 16.0, left: 16.0),
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
                        child: Text("State:",style: TextStyle(fontSize: 18.0),)),
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
                        child: Text("Description:",style: TextStyle(fontSize: 18.0),)),
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
                          _selectBirthDate(context);
                        },
                        child: ListTile(
                          leading: Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: Colors.red,
                          ),
                          title: Text("Birthdate"),
                        )),

                      Container(
                          padding: EdgeInsets.only(left:16.0),
                          child : Text("Birthdate : $birthday"))  ,
                    Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text("Phone:",style: TextStyle(fontSize: 18.0),)),
                    Container(
                      margin:
                          EdgeInsets.only(bottom: 12.0, right: 16.0, left: 16.0),
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
