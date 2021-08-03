import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_camp/screens/discussion/mainScreen/discussion.dart';

class Comment extends StatefulWidget {
  const Comment({Key key}) : super(key: key);

  @override
  _Comment createState() => _Comment();
}

class _Comment extends State<Comment> {
  var text = new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: new TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        new TextSpan(text: 'username:', style: new TextStyle(fontWeight: FontWeight.bold)),
        new TextSpan(
            text: 'World h,flhnlmshnlkd,lkh,kqe,h legh,kh,k r,gk,erk,splg '),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
   
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 14.0, right: 14.0),
           
            child: Row(
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Danny_DeVito_by_Gage_Skidmore.jpg/1200px-Danny_DeVito_by_Gage_Skidmore.jpg"),
                  
                  ),
                ),
                Container(
                 
                    padding: EdgeInsets.only(left: 20),
                    child: 
                      Column(children: [ 
                        Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: text),
                    ],)
                         
                ),
                    Spacer(),
                    Spacer(),
                      Container(
                  
                        child: GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Icon(
                            FontAwesomeIcons.fire,
                            color: true
                                ? Color.fromRGBO(207, 53, 46, 1)
                                : Color.fromRGBO(0, 0, 0, 1),
                            size: 27,
                          ),
                        ),
      
                      ),
                      Spacer(),
              ],
            ),
            
           
            



            
          
          ),
          
        ],
          
      ),
      margin: EdgeInsets.only(bottom: 10)
    );
  }
}
