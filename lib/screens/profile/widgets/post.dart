import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      ind = index + 1;
                    });
                  },
                  height:  MediaQuery.of(context).size.width * 0.744,
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
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                        margin: EdgeInsets.only(top: 2),
                      ),
                    ],
                  )),
            ],
          ),
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

      ),
      margin: EdgeInsets.only(bottom: 16),
    );
  }
}

/*  */
