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

  Question(this.id, this.title, this.topic, this.unit, this.options);

  static fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Question(
        doc.id,
        doc.get("title"),
        doc.get("topic"),
        doc.get("unit"),
        (doc.get('options') as List<dynamic>)
            .map((option) => Option(
                option['isCorrect'], option['text'], option['explanation']))
            .toList());
  }

  @override
  String toString() {
    return """
id: $id
Unit $unit - $topic
""";
  }
}
