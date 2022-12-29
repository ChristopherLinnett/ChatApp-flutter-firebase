import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage.text,
      'time': DateTime.now().toIso8601String(),
      'sender': FirebaseAuth.instance.currentUser?.uid
    });
    _enteredMessage.clear();
  }

  final TextEditingController _enteredMessage = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _enteredMessage,
                decoration: InputDecoration(
                  label: Text('Send Message'),
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage.text = value;
                    _enteredMessage.selection = TextSelection.collapsed(
                        offset: _enteredMessage.text.length);
                  });
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
              onPressed:
                  _enteredMessage.text.trim().isEmpty ? null : _sendMessage,
            ),
          ],
        ));
  }
}
