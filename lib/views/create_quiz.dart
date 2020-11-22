import 'package:flutter/material.dart';
import 'package:quiz_maker/services/firestore_service.dart';
import 'package:quiz_maker/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  String imageUrl, title, description, quizID;
  final _formKey = GlobalKey<FormState>();
  FirestoreService firestoreService = FirestoreService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
          : _createQuizBody(),
    );
  }

  Widget _createQuizBody() {
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
                    labelText: "Image URL",
                    icon: Icon(Icons.image),
                    filled: true,
                  ),
                  validator: (value) {
                    return value.isEmpty ? "Enter correct image URL" : null;
                  },
                  onChanged: (value) {
                    imageUrl = value;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Title",
                    icon: Icon(Icons.title),
                    filled: true,
                  ),
                  validator: (value) {
                    return value.isEmpty ? "Enter correct title" : null;
                  },
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Description",
                    icon: Icon(Icons.description),
                    filled: true,
                  ),
                  validator: (value) {
                    return value.isEmpty ? "Enter correct decription" : null;
                  },
                  onChanged: (value) {
                    description = value;
                  },
                ),
                SizedBox(height: 14),
                RaisedButton(
                  child: Text("Create quiz"),
                  onPressed: () {
                    createQuiz();
                  },
                  color: Colors.indigo,
                  textColor: Colors.white,
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  createQuiz() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      quizID = randomAlphaNumeric(16);
      Map<String, String> quizData = {
        "quizID": quizID,
        "imageUrl": imageUrl,
        "title": title,
        "description": description
      };
      firestoreService.createDada(quizData, quizID).then((value) {
        _isLoading = false;
        Navigator.pushReplacementNamed(context, "/add_question",
            arguments: quizID);
      });
    }
  }
}
