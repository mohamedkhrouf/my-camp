import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MessageType { sent, received }

class ChatMessage extends StatefulWidget {

  String senderImage;

  final String senderId;
final List members;
  final String message;
  final MessageType messageType;
  final Color backgroundColor;
  final Color textColor;
  final String time;
  final bool showTime;
  final double maxWidth;
  final double minWidth;

  ChatMessage(
      {this.message,
      this.messageType,
      this.backgroundColor,
      this.textColor,
      this.time,
      this.showTime,
      this.minWidth,
      this.maxWidth,
      this.senderImage,
      this.senderId, this.members});

  @override
  _ChatMessage createState() => _ChatMessage();
}

class _ChatMessage extends State<ChatMessage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // print(widget.members);
    FirebaseFirestore.instance
        .collection('user')
        .doc(widget.senderId)
        .get()
        .then((value) => setState(() {
              widget.senderImage = value.data()["avatar"];
            }));
  }

  CrossAxisAlignment messageAlignment() {
    if (widget.messageType == null ||
        widget.messageType == MessageType.received) {
      return CrossAxisAlignment.start;
    } else {
      return CrossAxisAlignment.end;
    }
  }

  double topLeftRadius() {
    if (widget.messageType == null ||
        widget.messageType == MessageType.received) {
      return 0.0;
    } else {
      return 12.0;
    }
  }

  double topRightRadius() {
    if (widget.messageType == null ||
        widget.messageType == MessageType.received) {
      return 12.0;
    } else {
      return 0.0;
    }
  }

  Color messageBgColor(BuildContext context) {
    if (widget.messageType == null ||
        widget.messageType == MessageType.received) {
      return Color.fromRGBO(36, 34, 47, 1);
    } else {
      return (Color.fromRGBO(170, 215, 62, 1));
    }
  }

  Color messageTextColor(BuildContext context) {
    if (widget.messageType == null ||
        widget.messageType == MessageType.received) {
      return Color(0xffffffff);
    } else {
      return Color(0xFFFFFFFF);
    }
  }

  Text messageTime() {
    if (widget.showTime != null && widget.showTime == true) {
      return Text(
        widget.time ?? "Time",
        style: TextStyle(
          fontSize: 12.0,
          color: Color(0xFF666666),
        ),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 24.0,
      ),
      child: Column(
        crossAxisAlignment: messageAlignment(),
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            (widget.messageType == null ||
                    widget.messageType == MessageType.received)
                ? Container(
                    margin: EdgeInsets.only(right: 10),
                    child: widget.senderImage == null
                        ? Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          )
                        : CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(widget.senderImage),
                            backgroundColor: Colors.transparent,
                          ),
                  )
                : Container(),
            Container(
              constraints: BoxConstraints(
                  minWidth: widget.minWidth ?? 100.0,
                  maxWidth: widget.maxWidth ??
                      MediaQuery.of(context).size.width * 0.55),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? messageBgColor(context),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topLeftRadius()),
                  topRight: Radius.circular(topRightRadius()),
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              child: Text(
                widget.message ?? "Message here...",
                style: TextStyle(
                  color: widget.textColor ?? messageTextColor(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            (widget.messageType == MessageType.sent)
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    child: widget.senderImage == null
                        ? Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          )
                        : CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(widget.senderImage),
                            backgroundColor: Colors.transparent,
                          ),
                  )
                : Container()
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 12.0,
            ),
            child: messageTime(),
          ),
        ],
      ),
    );
  }
}
