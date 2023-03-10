import 'package:flutter/material.dart';
import 'screens/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterFire Samples',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey[900]),
          colorScheme: const ColorScheme.dark().copyWith(
            primary: Colors.lightBlue,
            secondary: Colors.lightBlueAccent,
          )),
      home: SignInScreen(),
    );
  }
}
