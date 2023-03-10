import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("AP Computer Science A")),
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/images/apcs.png"),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary),
                    maximumSize:
                        MaterialStateProperty.all(const Size.fromWidth(150)),
                  ),
                  onPressed: () {},
                  child: Row(children: [
                    Image.asset(
                      "assets/logos/google.png",
                      width: 35,
                    ),
                    const Text("Sign in")
                  ]),
                )
              ]),
        ));
  }
}
