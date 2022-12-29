import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/u9IvdMTKzNbfo0Eo72lM/messages')
            .snapshots(),
        builder: (context, messageSnapshot) {
          final messages = messageSnapshot.data?.docs;
          if (messages == null) {
            return const CircularProgressIndicator.adaptive();
          }
          return messageSnapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator.adaptive())
              : ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: ((context, index) => Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(messages[index]['text']),
                      )),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/u9IvdMTKzNbfo0Eo72lM/messages')
              .add({'text': 'this was added by clicking button'});
        },
      ),
    );
  }
}
