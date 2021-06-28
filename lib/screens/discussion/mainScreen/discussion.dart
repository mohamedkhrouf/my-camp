import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_camp/screens/discussion/widgets/chatMessage.dart';
import 'package:my_camp/screens/tasks/mainScreen/tasks.dart';

class Discussion extends StatefulWidget {
  @override
  _Discussion createState() => _Discussion();
}

class _Discussion extends State<Discussion> {
  var messages = [
    ChatMessage(
      message:
          "ejri ejri ya mohamed l9it jara luizfdh,jdt,dtnsrnsrtnsrtyjtujtjkyultli",
      messageType: MessageType.sent,
    ),
    ChatMessage(
      time: "20:15",
      showTime: true,
    ),
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
    ChatMessage(
      message: "ejri ejri ya mohamed l9it jara luiz",
      messageType: MessageType.sent,
    ),
    ChatMessage(),
    ChatMessage(),
    ChatMessage(),
    ChatMessage(),
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
          )),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Expanded(
                child: SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return ChatMessage(
                            messageType: messages[index].messageType,
                            time: messages[index].time,
                            showTime: messages[index].showTime,
                            message: messages[index].message,
                          );
                        }))),
            Form(
                key: _formKey,
                child: Container(
                    margin: EdgeInsets.all(16.0),
                    child: Row(children: [
                      Icon(Icons.image,
                            size: 40,
                      ),
                      new Flexible(
                          child: TextFormField(
                        controller: taskController,
                        decoration: const InputDecoration(
                            hintText: 'Enter your message',
                            contentPadding: EdgeInsets.only(left: 15.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0))),
                            prefixIcon: Icon(Icons.search)),
                      )),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                allTasks.add(new TaskModel(
                                    taskName: taskController.text,
                                    state: true));
                              });
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.blue,
                              size: 40,
                            ),
                          )),
                    ]))),
          ])),
    );
  }
}
