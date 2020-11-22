import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> createDada(Map quizData, String quizID) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizID)
        .setData(quizData)
        .catchError((error) => print(error.toString()));
  }

  Future<void> addOptions(
      Map<String, String> optionsData, String quizID) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizID)
        .collection("QNA")
        .add(optionsData)
        .catchError((error) => print(error.toString()));
  }

  Stream<QuerySnapshot> getQuizData() {
    return Firestore.instance.collection("Quiz").snapshots();
  }
}
