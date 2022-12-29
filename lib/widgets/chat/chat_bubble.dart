import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key,
      required this.message,
      required this.isMe,
      this.username = ''});
  final String username;
  final String message;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          margin: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: isMe ? 60.0 : 5.0,
              right: isMe ? 5.0 : 60.0),
          decoration: BoxDecoration(
            color: isMe
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(isMe ? 0.0 : 30.0),
              bottomLeft: Radius.circular(isMe ? 30.0 : 0.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isMe ? 'You' : username,
                textAlign: isMe ? TextAlign.end : TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              Text(
                message,
                textAlign: isMe ? TextAlign.end : TextAlign.start,
                softWrap: true,
                maxLines: 10,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
