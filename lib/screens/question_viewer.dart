import 'package:flutter/material.dart';
import "package:flutter_html/flutter_html.dart";
import "../models/question.dart";

class QuestionViewer extends StatefulWidget {
  final Question question;
  final bool showAnswers;
  final Function(bool) onSelectAnswer;
  const QuestionViewer(
      {super.key,
      required this.question,
      required this.showAnswers,
      required this.onSelectAnswer});

  @override
  State<QuestionViewer> createState() => _QuestionViewerState();
}

class _QuestionViewerState extends State<QuestionViewer> {
  int? _chosenAnswer;

  @override
  void didUpdateWidget(covariant QuestionViewer oldWidget) {
    setState(() {
      if (oldWidget.showAnswers) {
        //Reset chosen answer if the "next" button is pressed
        //but not when "check" button is pressed
        _chosenAnswer = null;
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Html(
          data: widget.question.title,
          style: {
            ".inline_code, .code_line": Style(
              fontFamily: "monospace",
            ) //TODO: Make monospace work
          },
        ),
        Column(
          children: widget.question.options
              .asMap()
              .entries
              .map((entry) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _chosenAnswer = entry.key;
                      widget.onSelectAnswer(entry.value.isCorrect);
                    });
                  },
                  child: Card(
                      color: !widget.showAnswers || _chosenAnswer != entry.key
                          ? null
                          : entry.value.isCorrect
                              ? const Color.fromARGB(169, 38, 232, 45)
                              : const Color.fromARGB(169, 232, 48, 38),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(children: [
                          CircleAvatar(
                            maxRadius: 20,
                            backgroundColor: entry.key != _chosenAnswer
                                ? Theme.of(context).colorScheme.primary
                                : Colors.yellow,
                            child: Text(
                              ("ABCDE"[entry.key]),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          Expanded(
                              child: Html(
                                  data: !widget.showAnswers
                                      ? entry.value.text
                                      : entry.value.explanation))
                        ]),
                      ))))
              .toList(),
        )
      ],
    );
  }
}
