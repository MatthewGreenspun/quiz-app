import 'package:flutter/material.dart';
import "package:flutter_html/flutter_html.dart";
import "../models/question.dart";

class QuestionViewer extends StatefulWidget {
  final Question question;
  const QuestionViewer({super.key, required this.question});

  @override
  State<QuestionViewer> createState() => _QuestionViewerState();
}

class _QuestionViewerState extends State<QuestionViewer> {
  int? _chosenAnswer;

  @override
  void didUpdateWidget(covariant QuestionViewer oldWidget) {
    setState(() {
      _chosenAnswer = null;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Html(
          data: widget.question.title,
          style: {
            ".inline_code, .code_line": Style(
              fontFamily: "monospace",
            ) //TODO: Make monospace work
          },
        ),
        Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: widget.question.options
              .asMap()
              .entries
              .map((entry) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _chosenAnswer = entry.key;
                    });
                  },
                  child: Card(
                      color: _chosenAnswer == null || entry.key != _chosenAnswer
                          ? null
                          : entry.value.isCorrect
                              ? const Color.fromARGB(169, 38, 232, 45)
                              : const Color.fromARGB(169, 232, 48, 38),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(children: [
                          CircleAvatar(
                            maxRadius: 20,
                            backgroundColor: _chosenAnswer == null ||
                                    entry.key != _chosenAnswer
                                ? Theme.of(context).colorScheme.primary
                                : Colors.yellow,
                            child: Text(
                              ("ABCDE"[entry.key]),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          Expanded(child: Html(data: entry.value.text))
                        ]),
                      ))))
              .toList(),
        ))
      ],
    );
  }
}
