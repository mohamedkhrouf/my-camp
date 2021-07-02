import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_camp/screens/addEventFormPage/widgets/addImage.dart';
import 'package:my_camp/screens/addEventFormPage/widgets/imageContainer.dart';
import 'package:image_picker/image_picker.dart';
import '../../homePage/widgets/campSitesList.dart';

class AddEventForm extends StatefulWidget {

  @override
  _AddEventForm createState() => _AddEventForm();


}

class _AddEventForm extends State<AddEventForm> {
    List chosenImages = [];
    void deleteImage(int index) {
      setState(() {
          chosenImages.removeAt(index);
      });

    }

  File _image ;
  final _picker = ImagePicker();
  Future getImage() async {
    final image = await _picker.getImage(source:ImageSource.gallery);
    setState(() {
      _image=File(image.path);


      chosenImages.add(
          image.path

        //ImageContainer(imagePath: _image.path,index: chosenImages.length,deleteImage: deleteImage,          )
      );
    });
  }
  final descriptionController = TextEditingController();
  DateTime firstDate = DateTime.now();
  DateTime selectedCampingDate = DateTime.now();
  DateTime selectedPayementDate = DateTime.now();
  bool testCampingDate(selectedDate){
    DateTime today = DateTime.now();
    return (selectedDate.year==today.year &&
            selectedDate.month==today.month &&
            selectedDate.day== today.day);
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
          backgroundColor: Color.fromRGBO(36, 34, 47, 1)
          ,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0,top: 20),
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "Publish",
                  style: TextStyle(
                      color:Color.fromRGBO(170, 215, 62, 1),

                  ),
                )
              )
          ),
        ],

        ),
      body:Container(
          padding : EdgeInsets.only(top: 32.0),
          margin: EdgeInsets.only(left: 16.0),
        child: ListView(
         // mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Container(
              child: Text("Hello username",
              style: TextStyle(
                fontSize: 28
              ),),
            ),
            Container(
              child: Text("Let's create a new camping event",
                  style: TextStyle(
                    fontSize: 24
              ),),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0,right: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: 'Enter event name',
                    contentPadding: EdgeInsets.only(left: 15.0,top: 3,bottom: 3),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(16.0))),
                ),

                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              )
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.images,color: Colors.green,),
              title: Text("Choose an image"),
            ),
            Container(
              child:Wrap(
                  spacing: 8.0,
                  children: [
                    (chosenImages.length<6) ?
                    GestureDetector(
                      onTap: (){
                        getImage();

                      },
                      child:AddImage() ,
                    )
                    :
                    Container(),
                    ...chosenImages.asMap().entries.map((e)
                    {
                      return ImageContainer(imagePath: e.value,index: e.key,deleteImage: deleteImage,) as Widget;
                    }
                    ),
                  ],
                ),

            ),
            GestureDetector(
              onTap:  (){
                _selectCampingDate(context);
                }
        ,
                child:ListTile(
                  leading: Icon(FontAwesomeIcons.calendarAlt,color: Colors.red,),
                  title: Text("Camping date"),
                )
            ),
            testCampingDate(selectedCampingDate) ? Container() : Text("Camping Date : $selectedCampingDate"),
            GestureDetector(
                onTap:  (){
                  _selectPayementDate(context);
                }
                ,
                child:ListTile(
                  leading: Icon(FontAwesomeIcons.calendarAlt,color: Colors.red,),
                  title: Text("Payement deadline"),
                )
            ),
            GestureDetector(
                onTap:  (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CampSitesList()),
                  );
                }
                ,
                child:ListTile(
                  leading: Icon(FontAwesomeIcons.mapMarkerAlt,color: Colors.red,),
                  title: Text("Choose position"),
                )
            ),


          ]
        )
      ),
    );
  }
}