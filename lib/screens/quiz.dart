import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/global_store.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/screens/question_viewer.dart';

class Quiz extends StatefulWidget {
  final int _unit;
  final List<Question> _questions;
  const Quiz({super.key, required int unit, required List<Question> questions})
      : _unit = unit,
        _questions = questions;

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalStore>(
        builder: (_, globalStore, __) => Observer(
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text("Unit ${widget._unit}"),
                    actions: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _currentQuestion = max(0, _currentQuestion - 1);
                            });
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _currentQuestion = min(
                                  widget._questions.length - 1,
                                  _currentQuestion + 1);
                            });
                          },
                          icon: const Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                  body: QuestionViewer(
                    question: widget._questions[_currentQuestion],
                  ),
                )));
  }
}
