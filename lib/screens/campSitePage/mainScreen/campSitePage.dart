import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/campSitePage/widgets/widgets/post.dart';
import 'package:my_camp/screens/homePage/mainScreen/mapPage.dart';

class CampSitePage extends StatefulWidget {
  final campSiteData ;

  const CampSitePage({Key key, this.campSiteData}) : super(key: key);
  @override
  _CampSitePage createState() => _CampSitePage();
}

class _CampSitePage extends State<CampSitePage> {
  List campSitePosts = [] ;
  CollectionReference postRef = FirebaseFirestore.instance.collection("post");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0 ; i< widget.campSiteData["posts"].length ; i++)
      {
        postRef.doc((widget.campSiteData["posts"])[i].id).get().then((value) {
          if(mounted)
          setState(() {
            campSitePosts.add(value);
          });

        }
        );
      }
  }
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
                            widget.campSiteData["name"],
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
              padding: EdgeInsets.only(
                  left: 22.0,
                  ),

            ),
            Container(

              child: Text(
                widget.campSiteData["description"],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.only(top: 10, bottom: 10),
            ),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        left: 50,
                        right: 50)),
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    )),
              ),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapPage(
                          latitude: widget.campSiteData["latitude"],
                          longitude: widget.campSiteData["longitude"],
                        )))
              },
              child: Text('Map'),
            ),
          campSitePosts.length==0 ?
              Container(margin: EdgeInsets.only(top:250) ,child: Center(child: Text("No post for this camp site"),),):
              Container(),
          ...campSitePosts.map((e) =>
              Post(yep : e.data(), id: e.id,)
          ),
          ],
        ),
      ),
    );
  }
}