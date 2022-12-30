import 'dart:io';

import 'package:chat_app_firebase_flutter/widgets/login_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  var isLoading = false;

  Future<void> _submitAuthForm(
      {required Map userDetails,
      required AuthMode authMode,
      File? image,
      required BuildContext ctx}) async {
    UserCredential authResult;

    setState(() {
      isLoading = true;
    });
    try {
      if (authMode == AuthMode.login) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: userDetails['email'], password: userDetails['password']);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: userDetails['email'], password: userDetails['password']);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${authResult.user?.uid ?? ''}.jpg');
        String? url;
        await ref.putFile(image!).whenComplete(() async {
          url = await ref.getDownloadURL();
        });
        if (url == null) {
          return;
        }
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'email': userDetails['email'],
          'username': userDetails['username'],
          'image_url': url
        });
      }
    } on FirebaseAuthException catch (e) {
      var message = 'An Error Has Occurred, Please Check Credentials';
      if (e.message != null) {
        message = e.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            message,
            textScaleFactor: 1.1,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LoginCard(authCallback: _submitAuthForm, showLoader: isLoading),
    );
  }
}
