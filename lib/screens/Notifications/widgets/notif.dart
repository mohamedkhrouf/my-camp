import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notif extends StatefulWidget {

  @override
  _Notif createState() => _Notif();
}

class _Notif extends State<Notif> {

  @override
  Widget build(BuildContext context) {
    return  Container(
         width:  MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 16),
          color: Color.fromRGBO(241,249,255,1),
          padding: EdgeInsets.only(top:16.0,bottom: 16.0,left:16.0),
          child: Row(
            children: [
              Container(
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Container(
                        child:
                            Text("John Doe ", style: TextStyle(fontSize: 20)),
                      
                      ),
                      Container(
                        child: Text("San francisco",
                            style: TextStyle(fontSize: 15)),
                        
                      ),
                    ],
                  )),
              Expanded(
                  child: Align(
                child: Container(
                  child: Row(
                    children: [
                      Spacer(),
                        Container(child:ElevatedButton(
                        onPressed: () {},
                        child: Icon(Icons.check_sharp, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10),
                          primary: Colors.blue, // <-- Button color
                          onPrimary: Colors.red, // <-- Splash color
                        ),
                      ),
                      
                      ),
                      Container(child:
                      ElevatedButton(
                        onPressed: () {},
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
