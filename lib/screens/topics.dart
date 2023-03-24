import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/global_store.dart';
import 'package:quiz_app/widgets/app_bar_title.dart';
import 'quiz_widget.dart';
import "../widgets/progress.dart";

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
                  Expanded(
                      child: ListView(shrinkWrap: true, children: [
                    Text(
                      "Welcome, ${globalStore.user?.displayName}!",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Progress(progress: globalStore.progress),
                    const Text(
                      "Review",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                    ...globalStore.units.entries
                        .map((entry) => Card(
                              child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                                "Unit ${entry.key} - ${entry.value}")),
                                        globalStore.quizzes[entry.key] != null
                                            ? Expanded(
                                                flex: 1,
                                                child: Text(
                                                    "${globalStore.quizzes[entry.key]!.last.score} / ${globalStore.quizzes[entry.key]!.last.totalQuestions}"))
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
                  ])),
                ]),
              ),
            ));
  }
}
