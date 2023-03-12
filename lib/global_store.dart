import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:quiz_app/models/quiz.dart';
import "./models/question.dart";
import 'package:firebase_auth/firebase_auth.dart';
part 'global_store.g.dart';

class GlobalStore = _GlobalStore with _$GlobalStore;

abstract class _GlobalStore with Store {
  final questions = ObservableList<Question>();
  final quizzes = ObservableMap<int, Quiz>();

  @observable
  User? user;

  @computed
  double get progress {
    if (questions.isEmpty) return 0;
    return quizzes.entries.fold(
            0, (previousValue, entry) => previousValue + entry.value.score) /
        questions.length;
  }

  final units = {
    1: "Primitive Types",
    2: "Using Objects",
    3: "If statements",
    4: "Iterations",
    5: "Writing Classes",
    6: "Arrays",
    7: "ArrayList",
    8: "2D Arrays",
    9: "Inheritance",
    // 10: "Recursion" // TODO: not in database yet
  };

  @action
  listenForAuth() {
    FirebaseAuth.instance.userChanges().listen((User? userChange) {
      user = userChange;
      if (user != null) {
        getQuestions();
        getQuizzes();
      }
    });
  }

  @action
  getQuestions() {
    FirebaseFirestore.instance
        .collection('questions')
        .where("unit", isNull: false)
        .get()
        .then((value) {
      questions.clear();
      value.docs.forEach((doc) {
        questions.add(Question.fromFirebase(doc));
      });
    });
  }

  @action
  getQuizzes() {
    if (user == null) return;
    FirebaseFirestore.instance
        .collection("users/${user!.uid}/quizzes")
        .get()
        .then((q) {
      quizzes.clear();
      for (int i = 0; i < q.docs.length; i++) {
        final doc = q.docs[i];
        quizzes[doc.get("unit")] = Quiz.fromFirebase(doc);
      }
    });
  }

  @action
  setQuizProgress(Quiz quiz) {
    if (user == null) return;
    FirebaseFirestore.instance.collection("users/${user!.uid}/quizzes").add({
      "unit": quiz.unit,
      "score": quiz.score,
      "totalQuestions": quiz.totalQuestions,
      "wrongQuestions": quiz.wrongQuestions,
    }).then((_) => getQuizzes());
  }
}
