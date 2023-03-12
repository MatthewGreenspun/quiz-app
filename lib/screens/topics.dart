import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/global_store.dart';
import 'package:quiz_app/widgets/app_bar_title.dart';
import 'quiz_widget.dart';

class Topics extends StatelessWidget {
  const Topics({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalStore>(
        builder: (_, globalStore, __) => Observer(
              builder: (_) => Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: const AppBarTitle(),
                ),
                body: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome, ${globalStore.user?.displayName}!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 40),
                      child: Column(children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            width: 250,
                            height: 250,
                            child: CircularProgressIndicator(
                              value: globalStore.progress,
                              strokeWidth: 8,
                              backgroundColor: Colors.grey[700],
                            )),
                        Text(
                            "${(globalStore.progress * 100).round()}% Completed")
                      ])),
                  const Text(
                    "Review",
                    style: TextStyle(fontSize: 30),
                  ),
                  Expanded(
                      child: ListView(
                    children: globalStore.units.entries
                        .map((entry) => Card(
                              child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Unit ${entry.key} - ${entry.value}"),
                                        globalStore.quizzes[entry.key] != null
                                            ? Text(
                                                "${globalStore.quizzes[entry.key]!.score} / ${globalStore.quizzes[entry.key]!.totalQuestions}")
                                            : Container(),
                                        OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QuizWidget(
                                                            unit: entry.key,
                                                            questions: globalStore
                                                                .questions
                                                                .where((q) =>
                                                                    q.unit ==
                                                                    entry.key)
                                                                .toList(),
                                                          )));
                                            },
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  globalStore.quizzes[
                                                              entry.key] ==
                                                          null
                                                      ? const Icon(Icons.quiz)
                                                      : Container(),
                                                  Text(globalStore.quizzes[
                                                              entry.key] ==
                                                          null
                                                      ? "Quiz"
                                                      : "Retake")
                                                ]))
                                      ])),
                            ))
                        .toList(),
                  )),
                ]),
              ),
            ));
  }
}
