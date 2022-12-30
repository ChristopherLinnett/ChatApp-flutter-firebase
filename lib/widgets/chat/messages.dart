import 'package:chat_app_firebase_flutter/widgets/chat/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (chatSnapshot.data == null) {
            return Center(
              child: Text('ERROR'),
            );
          }
          final chatDocs = chatSnapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatSnapshot.data?.docs.length,
            itemBuilder: (context, index) => ChatBubble(
                key: ValueKey(chatDocs[index].id),
                message: chatDocs[index]['text'],
                isMe: chatDocs[index]['sender'] ==
                    FirebaseAuth.instance.currentUser?.uid.toString(),
                username: chatDocs[index]['username'],
                imageUrl: chatDocs[index]['image_url']),
          );
        });
  }
}
