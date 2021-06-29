import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/homePage/mainScreen/mapPage.dart';

class EvPage extends StatefulWidget {
  @override
  _EvPageState createState() => _EvPageState();
}

class _EvPageState extends State<EvPage> {
  var clicked=false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Color.fromRGBO(188, 224, 253, 1),
            height: MediaQuery.of(context).size.width * 0.2311,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Spacer(),
               
                 Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/mekki.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
                Spacer(),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
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
                            textAlign: TextAlign.left,
                          ),
                          margin: EdgeInsets.only(right: 40),
                        ),
                      ],
                    )),
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
                ),
                Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(color: Colors.brown),
                                  primary: Colors.white,
                                  padding: !clicked?EdgeInsets.only(
                                      top: 15, bottom: 15, left: 50, right: 50):
                                      EdgeInsets.only(
                                      top: 15, bottom: 15, left: 32.5, right: 32.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30)),
                                   )),
                              onPressed: () {
                                setState(() {
                                  clicked = !clicked;
                                });
                              },
                              child: !clicked?Text('Join'):Text('pending...'),
                            ),
                            margin: EdgeInsets.only(right: 20),
                          ),
                          Container(
                            child: ElevatedButton(
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
                                        builder: (context) => MapPage()))
                              },
                              child: Text('Map'),
                            ),
                            margin: EdgeInsets.only(left: 20),
                          )
                        ]),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.744 * 0.75)),
              ],
            )),
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
