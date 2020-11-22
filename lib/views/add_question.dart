import 'package:flutter/material.dart';
import 'package:quiz_maker/services/firestore_service.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class AddQuestions extends StatefulWidget {
  @override
  _AddQuestionsState createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  String question, option1, option2, option3, option4, quizID;
  final _formKey = GlobalKey<FormState>();
  FirestoreService firestoreService = FirestoreService();
  bool _isLoading = false;

  uploadQuizData() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> options = {
        "qustion": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };
      print("performing");
      firestoreService.addOptions(options, quizID).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings routeSettings = ModalRoute.of(context).settings;
    setState(() {
      quizID = routeSettings.arguments;
    });
    print(quizID);
    return Scaffold(
      appBar: AppBar(
        title: appBar(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : _createQuizQuestionsBody(),
    );
  }

  Widget _createQuizQuestionsBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Question",
                    icon: Icon(Icons.question_answer),
                    filled: true,
                  ),
                  validator: (value) {
                    return value.isEmpty ? "Enter correct image URL" : null;
                  },
                  onChanged: (value) {
                    question = value;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Option 1 (correct)",
                    icon: Icon(Icons.question_answer_outlined),
                    filled: true,
                  ),
                  validator: (value) {
                    return value.isEmpty ? "Enter correct title" : null;
                  },
                  onChanged: (value) {
                    option1 = value;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Option 2",
                    icon: Icon(Icons.question_answer_outlined),
                    filled: true,
                  ),
                  validator: (value) {
                    return value.isEmpty ? "Enter an option" : null;
                  },
                  onChanged: (value) {
                    option2 = value;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Option 3",
                    icon: Icon(Icons.question_answer_outlined),
                    filled: true,
                  ),
                  validator: (value) {
                    return value.isEmpty ? "Enter an option" : null;
                  },
                  onChanged: (value) {
                    option3 = value;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Option 4",
                    icon: Icon(Icons.question_answer_outlined),
                    filled: true,
                  ),
                  validator: (value) {
                    return value.isEmpty ? "Enter an option" : null;
                  },
                  onChanged: (value) {
                    option4 = value;
                  },
                ),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text("Submit"),
                      onPressed: () {
                        uploadQuizData();
                        Navigator.pop(context);
                      },
                      color: Colors.indigo,
                      textColor: Colors.white,
                    ),
                    RaisedButton(
                      child: Text("Add another question"),
                      onPressed: () {
                        uploadQuizData();
                      },
                      color: Colors.indigo,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
