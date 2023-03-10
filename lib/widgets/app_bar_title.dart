import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/logos/firebase.png',
          height: 20,
        ),
        const SizedBox(width: 8),
        const Text(
          'FlutterFire',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 18,
          ),
        ),
        const Text(
          ' Authentication',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
