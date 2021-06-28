import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/campSitePage/mainScreen/campSitePage.dart';

class CampSite extends StatefulWidget {

  @override
  _CampSite createState() => _CampSite();
}

class _CampSite extends State<CampSite> {
  @override
  Widget build(BuildContext context)
  {
    return Container(child: Stack(children:[
      Container(
      width: MediaQuery.of(context).size.width,
      color: Color.fromRGBO(188, 224, 253,1),
      margin: EdgeInsets.only(right: 16.0, left:16.0 , bottom:8.0),
      padding: EdgeInsets.only(right:16.0,left: 16.0,top: 16.0,bottom: 36.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(child:Text("esm l blasa")),
          Container(child:Text("location")),
          Container(child:Text("text twillllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll")),

        ],
      ),
    ),
      Positioned(

        right: 20.0,
        bottom: 10.0,
        child:GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CampSitePage()),
            );
          },
            child:Row(
          children: [
            Text("More"),
            Icon(Icons.arrow_forward)
          ],
        )),
      )
    ]));
  }
}