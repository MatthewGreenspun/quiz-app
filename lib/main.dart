import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/global_store.dart';
import 'screens/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<GlobalStore>(
            create: (_) => GlobalStore()
              ..listenForAuth()
              ..getQuestions()
              ..getQuizzes(),
          ),
        ],
        child: MaterialApp(
          title: 'FlutterFire Samples',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
              bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey[900]),
              colorScheme: const ColorScheme.dark().copyWith(
                primary: Colors.blue,
                secondary: Colors.blueAccent,
              )),
          home: SignInScreen(),
        ));
  }
}
