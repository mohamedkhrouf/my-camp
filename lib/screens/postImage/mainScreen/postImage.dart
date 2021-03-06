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
import 'package:my_camp/screens/postImage/widgets/positionsList.dart';
import 'package:my_camp/screens/loading/mainScreen/loading.dart';

import '../../homePage/widgets/campSitesList.dart';

class PostImage extends StatefulWidget {
  final user;

  const PostImage({Key key, this.user}) : super(key: key);
  @override
  _PostImage createState() => _PostImage();
}

class _PostImage extends State<PostImage> {
  var loading = false ;
  List chosenImages = [];
  final descriptionController = TextEditingController();
  var position ;
  final _formKey = GlobalKey<FormState>();
  var username = "";
  var imagesError = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = widget.user.data()["username"];
  }
  void getPosition(pos){
    setState(() {
      position=pos ;
    });
  }
  Future uploadImageToFirebase(BuildContext context) async {
    List chosenImagesUrl = [];

    var image;
    FirebaseStorage storage = FirebaseStorage.instance;

    for (File image in chosenImages) {
      Reference ref = storage.ref().child("$image" + DateTime.now().toString());
      TaskSnapshot uploadTask =await ref.putFile(image);
      var imgUrl = await uploadTask.ref.getDownloadURL();
      chosenImagesUrl.add(imgUrl);
    }
    print(chosenImagesUrl);
    return chosenImagesUrl;

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







  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
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
                      if(_formKey.currentState.validate()&& chosenImages.length > 0) {
                        setState(() {
                          loading=true ;
                        });
                        uploadImageToFirebase(context).then((value) {
                          print(value);
                          CollectionReference collectionReference =
                          FirebaseFirestore.instance.collection('post');
                          collectionReference.add({
                            'text': descriptionController.text,
                            'userId': FirebaseFirestore.instance.collection(
                                'user').
                            doc(FirebaseAuth.instance.currentUser.uid),
                            'placeId': position,
                            'publicationDate': DateTime.now(),
                            'images': value,
                            'likes': [],
                          }).then((value) {
                            FirebaseFirestore.instance.collection("place").doc(position).update({
                              'posts' : FieldValue.arrayUnion([value])
                            }

                            );
                            descriptionController.clear();
                            Navigator.of(context).pop();
                          }).catchError(
                                  (error) {
                                    setState(() {
                                      loading=false ;
                                    });
                                  });
                        });
                      }


                    },
                    child: Text(
                      "Publish",
                        style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1),fontSize: 16)
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
                      margin: EdgeInsets.only(top:60),
                      child: Text(
                        "Hello ${username}",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Let's create a new Post",
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
                            hintText: 'Enter post Description',
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

                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.images,
                        color: Colors.green,
                      ),
                      title: Text("Choose your images"),
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
    /*        Container(
                margin: EdgeInsets.only(right:16.0),
                child:Padding(

              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {

                },
                padding: EdgeInsets.all(12),

                color: Color.fromRGBO(36, 34, 47, 1),
                child: Text('Submit', style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1),fontSize: 20)),
              ),
            ))*/





                  ])),
        ));
  }
}
