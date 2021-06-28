import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/homePage/mainScreen/mapPage.dart';
import 'package:my_camp/screens/profile/widgets/image.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var items = [1, 2, 3, 4, 5];
  var ind = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                ind = index + 1;
              });
            },
            height: 300.0,
            viewportFraction: 1,
            enableInfiniteScroll: false,
          ),
          items: items.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return ImagePage(url: 'assets/mekki.jpg');
              },
            );
          }).toList(),
        ),
        Positioned(
            right: 10,
            top: 5,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: 10,
                  ),
                  
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  child: Text(
                    ' $ind/${items.length}',
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                  margin: EdgeInsets.only(top: 2),
                ),
              ],
            )),
      ]),
     margin: EdgeInsets.only(bottom:16),
    );
  }
}

/*  */
