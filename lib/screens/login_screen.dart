import 'package:chat_app_firebase_flutter/widgets/login_card.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _submitAuthForm({
    required Map userDetails,
    required AuthMode authMode,
  }) {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LoginCard(authCallback: _submitAuthForm),
    );
  }
}
