import 'package:flutter/material.dart';
import 'package:quiz_app/screens/topics.dart';
import "./screens/login.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "./firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey[900]),
          colorScheme: const ColorScheme.dark().copyWith(
            primary: Colors.lightBlue,
            secondary: Colors.lightBlueAccent,
          )),
      home: const Topics(),
    );
  }
}
