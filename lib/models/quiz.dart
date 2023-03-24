import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  int unit;
  int score;
  int totalQuestions;
  List<String> wrongQuestions;
  DateTime timestamp;

  Quiz(
      {required this.unit,
      required this.score,
      required this.totalQuestions,
      required this.wrongQuestions,
      required this.timestamp});

  static fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Quiz(
        unit: doc.get("unit"),
        score: doc.get("score"),
        totalQuestions: doc.get("totalQuestions"),
        wrongQuestions: (doc.get("wrongQuestions") as List<dynamic>)
            .map((qId) => qId.toString())
            .toList(),
        timestamp: (doc.get("timestamp") as Timestamp).toDate());
  }

  @override
  String toString() {
    return "Quiz $unit. Score: $score $totalQuestions";
  }
}
