import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
enum MessageType { sent, received }

class ChatMessage extends StatelessWidget {
  final String senderImage ;
  final String message;
  final MessageType messageType;
  final Color backgroundColor;
  final Color textColor;
  final String time;
  final bool showTime;
  final double maxWidth;
  final double minWidth;
ChatMessage(
    {this.message, this.messageType, this.backgroundColor, this.textColor, this.time, this.showTime, this.minWidth, this.maxWidth, this.senderImage});

CrossAxisAlignment messageAlignment() {
  if (messageType == null || messageType == MessageType.received) {
    return CrossAxisAlignment.start;
  } else {
    return CrossAxisAlignment.end;
  }
}

double topLeftRadius() {
  if (messageType == null || messageType == MessageType.received) {
    return 0.0;
  } else {
    return 12.0;
  }
}

double topRightRadius() {
  if (messageType == null || messageType == MessageType.received) {
    return 12.0;
  } else {
    return 0.0;
  }
}

Color messageBgColor(BuildContext context) {
  if (messageType == null || messageType == MessageType.received) {
    return Color.fromRGBO(36, 34, 47, 1);
  } else {
    return (Color.fromRGBO(170, 215, 62, 1));
  }
}

Color messageTextColor(BuildContext context) {
  if (messageType == null || messageType == MessageType.received) {
    return Color(0xffffffff);
  } else {
    return Color(0xFFFFFFFF);
  }
}

Text messageTime() {
  if(showTime != null && showTime == true) {
    return Text(
      time ?? "Time",
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

        Row(
            mainAxisSize: MainAxisSize.min,
            children:[
        (messageType == null || messageType == MessageType.received) ?
        Container(

            margin: EdgeInsets.only(right: 10),

          child: CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(senderImage),
          backgroundColor: Colors.transparent,
        ),
        ): Container(),

        Container(
          constraints: BoxConstraints(minWidth: minWidth ?? 100.0, maxWidth: maxWidth ?? MediaQuery.of(context).size.width*0.55),
          decoration: BoxDecoration(
            color: backgroundColor ?? messageBgColor(context),
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
            message ?? "Message here...",
            style: TextStyle(
              color: textColor ?? messageTextColor(context),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
          (messageType == MessageType.sent) ?
          Container(

            margin: EdgeInsets.only(left: 10),

            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(senderImage),
              backgroundColor: Colors.transparent,
            ),
          )
              : Container()

        ]
        ),
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