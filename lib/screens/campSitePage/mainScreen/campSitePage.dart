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
        backgroundColor: Color.fromRGBO(36, 34, 47, 1)
        ,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            "CampSite",
            style: TextStyle(
              color: Color.fromRGBO(170, 215, 62, 1)
            ),
        ),
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

            PostPage(),
            PostPage(),
          ],
        ),
      ),
    );
  }
}