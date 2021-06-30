import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cont extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Color.fromRGBO(188, 224, 253, 1),
            padding: EdgeInsets.only(top:16.0,bottom: 16.0),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 16),
            child: Row(

              children: [
                Spacer(),
               
                 Container(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                    NetworkImage("assets/mekki.jpg"),
                    backgroundColor: Colors.transparent,
                  ),
                 ),

                Spacer(),
                Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "name surname",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          margin: EdgeInsets.only(right: 10),
                        ),
                        Container(
                          child: Text(
                            "name surname",
                            style: TextStyle(fontSize: 15),

                          ),

                        ),
                      ],
                    )
                ),
                    Spacer(),
                     Spacer(),
                      Spacer(),
                       Spacer(),
                      Spacer(),
                       Spacer(),
 Spacer(),
                  Spacer(),
              ],
            )),
         Container(
            color: Colors.blue,
            height: MediaQuery.of(context).size.width * 0.744,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Image.asset(
                  'assets/mekki.jpg',
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),],),),
        Container(
            color: Color.fromRGBO(255, 255, 255, 1),
        
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Container(child:
                Row(
                  children: [
                   Container(child:
                    Icon(
                      Icons.favorite,
                      color: Color.fromRGBO(2, 255, 255, 1),

                    ),
                    margin:EdgeInsets.only(right:20)),
                    Container(child:
                    Icon(
                      Icons.add_comment,
                      color: Color.fromRGBO(2, 255, 255, 1),
                    ),)
                  ],
                ),
                margin: EdgeInsets.only(left: 10,top:10),
                ),
               Container(
                          child: Text(
                            "name surname lorem ipsum lorem ipsum lorem ipsum lorem lorem  ipsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaum lorem",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                        
                          margin: EdgeInsets.only(left: 10,right: 10),
                        ),
                  ],
                )
           )
      ],
    );
  }
}
