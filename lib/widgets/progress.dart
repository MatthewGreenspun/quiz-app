import "dart:math";

import "package:flutter/material.dart";

class Progress extends StatelessWidget {
  final double progress;
  const Progress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
        child: Column(children: [
          Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: min(250, deviceHeight / 3),
              height: min(250, deviceHeight / 3),
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 8,
                backgroundColor: Colors.grey[700],
              )),
          Text("${(progress * 100).round()}% Completed")
        ]));
  }
}
