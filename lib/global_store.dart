import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import "./models/question.dart";
import 'package:firebase_auth/firebase_auth.dart';
part 'global_store.g.dart';

class GlobalStore = _GlobalStore with _$GlobalStore;

abstract class _GlobalStore with Store {
  final questions = ObservableList<Question>();

  @observable
  User? user;

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
  setQuestions() {}

  @action
  listenForAuth() {
    FirebaseAuth.instance.userChanges().listen((User? userChange) {
      user = userChange;
    });
  }

  @action
  getQuestions() {
    FirebaseFirestore.instance
        .collection('questions')
        .where("unit", isNull: false)
        .get()
        .then((value) {
      value.docs.forEach((doc) {
        questions.add(Question.fromFirebase(doc));
      });
    });
  }
}
