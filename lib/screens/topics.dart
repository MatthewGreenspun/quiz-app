import 'package:flutter/material.dart';
import "package:flutter_html/flutter_html.dart";
import "../models/question.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Topics extends StatefulWidget {
  const Topics({super.key});

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  List<Question> questions = [];

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('questions')
        .where("unit", isEqualTo: 2)
        .get()
        .then((value) {
      value.docs.forEach((doc) {
        setState(() {
          questions.add(Question.fromFirebase(doc));
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Question 1")),
        body: questions.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Html(
                    data: questions[2].title,
                    style: {
                      ".inline_code, .code_line": Style(
                        fontFamily: "monospace",
                      ) //TODO: Make monospace work
                    },
                  ),
                  Column(
                    children: questions[2]
                        .options
                        .asMap()
                        .entries
                        .map((entry) => Card(
                            color: entry.value.isCorrect
                                ? Color.fromARGB(169, 38, 232, 45)
                                : null, // CORRECT
                            // color: Color.fromARGB(169, 232, 48, 38), // INCORRECT
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(children: [
                                CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor: entry.value.isCorrect
                                      ? Colors.yellow
                                      : // AFTER CLICK
                                      Theme.of(context).colorScheme.primary,
                                  child: Text(("ABCDE"[entry.key])),
                                ),
                                Expanded(child: Html(data: entry.value.text))
                              ]),
                            )))
                        .toList(),
                  )
                ],
              ));
  }
}
