import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  Future<void> _sendMessage() async {
    if (_enteredMessage.text.isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userDetails = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage.text,
      'time': DateTime.now().toIso8601String(),
      'sender': FirebaseAuth.instance.currentUser?.uid,
      'username': userDetails['username'] ?? '',
      'image_url': userDetails['image_url']
    });
    _enteredMessage.clear();
    _enteredMessage.text = '';
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
                  errorBorder: InputBorder.none,
                  border: InputBorder.none,
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
