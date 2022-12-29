import 'package:chat_app_firebase_flutter/firebase_options.dart';
import 'package:chat_app_firebase_flutter/screens/chat_screen.dart';
import 'package:chat_app_firebase_flutter/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          primaryColorDark: Color.fromARGB(255, 4, 52, 92),
          backgroundColor: Color.fromARGB(255, 3, 94, 168),
          canvasColor: Colors.blue.shade300,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10)),
              elevation: MaterialStateProperty.all(5),
              textStyle: MaterialStateProperty.all(
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
              ),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ChatScreen();
              } else {
                return LoginScreen();
              }
            })));
  }
}
