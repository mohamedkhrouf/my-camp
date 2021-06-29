import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/campSitePage/widgets/widgets/post.dart';

class CampSitePage extends StatefulWidget {
  @override
  _CampSitePage createState() => _CampSitePage();
}

class _CampSitePage extends State<CampSitePage> {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        title: Text("Camp Site"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [

                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            "Camp site 125",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          margin: EdgeInsets.only(top: 16.0),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.071,
                  ),
            ),
            Container(
              child: Text(
                'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.only(top: 10, bottom: 0),
            ),
            Container(child:ElevatedButton(
              onPressed: () {},
              child: Icon(Icons.add, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),

                primary: Colors.blue, // <-- Button color
                onPrimary: Colors.red, // <-- Splash color
              ),
            ),
              margin: EdgeInsets.all(10),
            ),
            PostPage(),
            PostPage(),
          ],
        ),
      ),
    );
  }
}