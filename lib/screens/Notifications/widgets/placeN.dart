import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceN extends StatefulWidget {
  @override
  _PlaceN createState() => _PlaceN();
  final demand;
  final id;
  const PlaceN({Key key, this.demand, this.id}) : super(key: key);
}

class _PlaceN extends State<PlaceN> {
  
  var event;

  void initState() {
    super.initState();
 
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 16),
      color: Color.fromRGBO(241, 249, 255, 1),
      padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0),
      child: Row(
        children: [
         
          Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text( widget.demand["name"] ,
                        style: TextStyle(fontSize: 20)),
                  ),
                  Container(
                    child: Text(widget.demand["address"],
                        style: TextStyle(fontSize: 15)),
                  ),
                    Container(
                      
                    child: RichText(
                              text: new TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                             
                                  new TextSpan(
                                      text: widget.demand["description"]),
                                ],
                              ),
                            ),
                  ),
                ],
              )),
          Expanded(
              child: Align(
            child: Container(
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        // remove from pending
                        FirebaseFirestore.instance
                            .collection('place')
                            .doc(widget.id)
                            .update({
                              'pending': false
                            })
                            .then((value) => print("updated"))
                            .catchError((error) =>
                                print("Failed to update event: $error"));
                        //add to members
                      
                        // add event to user's events
                       
                      },
                      child: Icon(Icons.check_sharp, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10),
                        primary: Colors.blue, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        // remove from pending
                        FirebaseFirestore.instance
                            .collection('place')
                            .doc(widget.id)
                            .delete()
                            .then((value) => print('deleted'))
                            .catchError((error) =>
                                print("Failed to delete event: $error"));
                      
                      },
                      child: Icon(Icons.clear, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(10),
                        primary: Colors.grey, // <-- Button color
                      ),
                    ),
                  ),
                ],
              ),
            ),
            alignment: Alignment.bottomRight,
          ))
        ],
      ),
    );
  }
}
