import 'package:flutter/material.dart';

class FinishQuiz extends StatelessWidget {
  final String quizName;
  final int score;
  final int totalQuestions;
  const FinishQuiz(
      {super.key,
      required this.quizName,
      required this.score,
      required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            quizName,
            style: const TextStyle(fontSize: 30),
          ),
          Text(
            "$score / $totalQuestions",
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            score == totalQuestions ? "Great Job!" : "Keep Practicing",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(child: Image.asset("assets/logos/java.png"))
        ]));
  }
}
