import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.isMe});
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isMe) Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          margin: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: isMe ? 100.0 : 1.0,
              right: isMe ? 1.0 : 100.0),
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
            children: [
              Container(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              Container(
                height: 5.0,
                decoration: BoxDecoration(
                  color: isMe ? Colors.lightBlueAccent : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isMe ? 0.0 : 10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(isMe ? 10.0 : 0.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
