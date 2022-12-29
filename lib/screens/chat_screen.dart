import 'package:chat_app_firebase_flutter/widgets/chat/messages.dart';
import 'package:chat_app_firebase_flutter/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Chat'),
        actions: [
          PopupMenuButton(
            offset: Offset(0, 40),
            icon: Icon(Icons.more_vert),
            color: Theme.of(context).primaryIconTheme.color,
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  value: 'logout',
                  child: TextButton.icon(
                    icon: Icon(Icons.logout),
                    label: Text('Log Out'),
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
