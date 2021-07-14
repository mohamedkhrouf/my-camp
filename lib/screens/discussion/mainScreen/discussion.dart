import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_camp/screens/discussion/widgets/chatMessage.dart';
import 'package:my_camp/screens/tasks/mainScreen/tasks.dart';

class Discussion extends StatefulWidget {
  final eventId ;

  const Discussion({Key key, this.eventId}) : super(key: key);
  @override
  _Discussion createState() => _Discussion();
}

class _Discussion extends State<Discussion> {
  /*var messages = [
    ChatMessage(
      message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      messageType: MessageType.sent,
    ),
    ChatMessage(
      time: "20:15",
      showTime: true,
    ),
    ChatMessage(
      message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    ),
    ChatMessage(),
    ChatMessage(),
    ChatMessage(
      message: "ejri ejri ya mohamed l9it jara luiz",
      messageType: MessageType.sent,
    ),
    ChatMessage(),
    ChatMessage(),
    ChatMessage(),
    ChatMessage(),
    ChatMessage(
      message: "ejri ejri ya mohamed l9it jara luiz",
      messageType: MessageType.sent,
    ),
    ChatMessage(),
    ChatMessage(),
    ChatMessage(),
    ChatMessage(),
  ];*/
  var messages = [] ;
  var images=[];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages();
  }
  List getMessages() {
print(widget.eventId)  ;
    FirebaseFirestore.instance.collection('event').doc(widget.eventId).
    collection('messages').orderBy("sendTime" ).snapshots().listen((snapshot) {
      if (mounted) {
        setState(() {
          messages= snapshot.docs ;

          for(int i =0 ; i< messages.length ; i++){
            FirebaseFirestore.instance.collection('user').doc(messages[i].data()["senderId"].id).get().then((value)
                {
                  setState(() {
                    images.add(value.data()["avatar"]);

                  });
                } );
          }

          //print(documents[3].data());
          // usersList = snapshot.docs;
        });
      }
    });

    print(images);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 34, 47, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(170, 215, 62, 1)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Esml l groupe",
          style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0,top: 20),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tasks()),
                    );
                  },

                    child: Text("Tasks",style: TextStyle(color: Color.fromRGBO(170, 215, 62, 1)),),

                  )),
        ],
      ),

      /* PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Icon(Icons.arrow_back),
                    margin: EdgeInsets.only(right: 20.0),
                  ),
                ),
                Text(
                  "Group name",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tasks()),
                    );
                  },
                  child: Text("Tasks"),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(right: 16.0, left: 16.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                )
              ],
            ),
            padding: EdgeInsets.all(16.0),
          )
      ),*/
      body: Container(
        color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Expanded(
                child: SingleChildScrollView(
                    reverse: true,
                    physics: ScrollPhysics(),

                    child:

                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: messages.length,
                        itemBuilder: (context, index) {

                          return ChatMessage(
                            messageType: messages[index].data()["senderId"].id == FirebaseAuth.instance.currentUser.uid ? MessageType.sent : MessageType.received,
                            //time: messages[index].data()["sendTime"],
                            message: messages[index].data()["text"],
                            senderImage: images[index],
                          );
                        }
                        )
                )
            ),
            Form(

                key: _formKey,
                child: Container(

                    decoration: BoxDecoration(
                      color: Colors.white,

                      boxShadow: [
                      BoxShadow(
                        blurRadius:64,
                        color: Color(0xFF087949).withOpacity(0.4),
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                    padding: EdgeInsets.only(top: 8.0,right: 16.0, left: 16.0,bottom: 8.0),
                    child: Row(children: [
                      /* GestureDetector(
                          onTap: () {
                            setState(() {
                              print("hrgnrs");
                            });
                          },
                          child:Container(

                              child:Icon(
                            Icons.image,
                            color: Color.fromRGBO(170, 215, 62, 1),
                            size: 40,
                          ))),*/
                      new Flexible(
                          child: Container(
                              height: 35,
                              child: TextFormField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your message',
                                  contentPadding: EdgeInsets.only(left: 15.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0))),
                                ),
                              ))),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: GestureDetector(

                            onTap: () async {

                              final newMessage= await FirebaseFirestore.instance.collection('event').doc(widget.eventId).collection('messages').add(
                                    {
                                      'eventId': FirebaseFirestore.instance.doc("event/"+widget.eventId),
                                      'senderId' : FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser.uid) ,
                                      'text' : messageController.text,
                                      'sendTime' : DateTime.now()
                                    });
             
                                messageController.clear();


                               /* messages.add(ChatMessage(
                                  message: messageController.text,
                                  messageType: MessageType.sent,
                                ));
                                messageController.clear();*/

                            },
                            child: Icon(
                              Icons.send,
                              color: Color.fromRGBO(170, 215, 62, 1),
                              size: 33,
                            )),
                      ),
                    ]))),
          ])),
    );
  }
}
