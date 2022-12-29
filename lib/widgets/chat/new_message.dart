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
        height: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            color: Theme.of(context).colorScheme.onPrimary),
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 3),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _enteredMessage,
                decoration: InputDecoration(
                  hintText: 'Send Message',
                  focusedBorder: InputBorder.none,
                  
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
