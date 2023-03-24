import 'package:cloud_firestore/cloud_firestore.dart';

class Option {
  bool isCorrect;
  String text;
  String explanation;
  Option(this.isCorrect, this.text, this.explanation);
}

class Question {
  String id;
  String topic;
  String title;
  int unit;
  List<Option> options;
  int correctAnswers;
  int totalAnswers;

  Question(this.id, this.title, this.topic, this.unit, this.options,
      this.correctAnswers, this.totalAnswers);

  static fromFirebase(dynamic doc) {
    return Question(
        doc.id,
        doc.get("title"),
        doc.get("topic"),
        doc.get("unit"),
        (doc.get('options') as List<dynamic>)
            .map((option) => Option(
                option['isCorrect'], option['text'], option['explanation']))
            .toList(),
        // doc. get("correctAnswers") ?? 0,
        doc.data()["correctAnswers"] ?? 0,
        doc.data()["totalAnswers"] ?? 0);
    // doc.get("totalAnswers") ?? 0);
  }

  @override
  String toString() {
    return """
{ id: $id, unit: $unit, topic: $topic, correctAnswers: $correctAnswers, totalAnswers: $correctAnswers }
""";
  }
}
