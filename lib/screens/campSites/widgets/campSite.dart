import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/campSitePage/mainScreen/campSitePage.dart';

class CampSite extends StatefulWidget {
  @override
  _CampSite createState() => _CampSite();
  final data;
  const CampSite({Key key, this.data}) : super(key: key);
}

class _CampSite extends State<CampSite> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(188, 224, 253, 1),
        margin: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
        padding:
            EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0, bottom: 36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
               widget.data["name"],
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              child: Text(
                ("Position: "+widget.data["latitude"]!=null?widget.data["latitude"].toString():"")+" , "+
                    (widget.data["longitude"]!=null?widget.data["longitude"]:"").toString(),
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 14.0,
                ),
              ),
            ),
            Container(
                child: Text(
              widget.data["description"],
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 16,
              ),
            )),
          ],
        ),
      ),
      Positioned(
        right: 20.0,
        bottom: 10.0,
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CampSitePage(campSiteData : widget.data)),
              );
            },
            child: Row(
              children: [
                Text(
                  "More",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 14 * 1.1,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Color.fromRGBO(0, 0, 0, 1),
                )
              ],
            )),
      )
    ]));
  }
}
