import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/global_store.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/screens/finish_quiz.dart';
import 'package:quiz_app/screens/question_viewer.dart';

class QuizWidget extends StatefulWidget {
  final int _unit;
  final List<Question> _questions;
  const QuizWidget(
      {super.key, required int unit, required List<Question> questions})
      : _unit = unit,
        _questions = questions;

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  static const correctColor = Color.fromARGB(169, 38, 232, 45);
  static const incorrectColor = Color.fromARGB(169, 232, 48, 38);
  int _currentQuestion = 0;
  bool _isAnswering = true; // false when user presses the "check" button
  bool _selectedAnswerIsCorrect = false;
  List<bool> _questionProgress = [];
  @override
  void initState() {
    _questionProgress = widget._questions.map((e) => false).toList();
    super.initState();
  }

  void onSelectAnswer(bool isCorrect) {
    setState(() {
      _selectedAnswerIsCorrect = isCorrect;
    });
  }

  int calculateScore() {
    return _questionProgress.fold(
        0, (previousValue, element) => previousValue + (element ? 1 : 0));
  }

  List<String> getWrongQuestions() {
    List<String> wrongQuestions = [];
    for (int i = 0; i < widget._questions.length; i++) {
      if (!_questionProgress[i]) {
        wrongQuestions.add(widget._questions[i].id);
      }
    }
    return wrongQuestions;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalStore>(
        builder: (_, globalStore, __) => Scaffold(
              appBar: AppBar(
                title: Text("Unit ${widget._unit}"),
              ),
              body: _currentQuestion >= widget._questions.length
                  ? FinishQuiz(
                      quizName:
                          "Unit ${widget._unit} ${globalStore.units[widget._unit]!}",
                      score: calculateScore(),
                      totalQuestions: widget._questions.length)
                  : QuestionViewer(
                      showAnswers: !_isAnswering,
                      question: widget._questions[_currentQuestion],
                      onSelectAnswer: onSelectAnswer,
                    ),
              bottomNavigationBar: _currentQuestion >= widget._questions.length
                  ? null
                  : BottomAppBar(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    children: widget._questions
                                        .asMap()
                                        .entries
                                        .map((entry) => Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10000),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: _currentQuestion <=
                                                            entry.key
                                                        ? null
                                                        : _questionProgress[
                                                                entry.key]
                                                            ? correctColor
                                                            : incorrectColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10000),
                                                    border: _currentQuestion <=
                                                            entry.key
                                                        ? Border.all(
                                                            color: Colors
                                                                .grey[500]!,
                                                            width: 2)
                                                        : null),
                                                width: entry.key ==
                                                        _currentQuestion
                                                    ? 14
                                                    : 10,
                                                height: entry.key ==
                                                        _currentQuestion
                                                    ? 14
                                                    : 10,
                                              ),
                                            )))
                                        .toList()),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        setState(() {
                                          if (_isAnswering) {
                                            _isAnswering = false;
                                            _questionProgress[
                                                    _currentQuestion] =
                                                _selectedAnswerIsCorrect;
                                            _selectedAnswerIsCorrect = false;
                                          } else {
                                            _isAnswering = true;
                                            _currentQuestion += 1;
                                            if (_currentQuestion ==
                                                widget._questions.length) {
                                              globalStore.setQuizProgress(Quiz(
                                                  unit: widget._unit,
                                                  score: calculateScore(),
                                                  totalQuestions:
                                                      widget._questions.length,
                                                  wrongQuestions:
                                                      getWrongQuestions()));
                                            }
                                          }
                                        });
                                      });
                                    },
                                    child: _isAnswering
                                        ? const Text("Check")
                                        : const Text("Next"))
                              ])),
                    ),
            ));
  }
}
