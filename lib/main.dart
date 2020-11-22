import 'package:flutter/material.dart';
import 'package:quiz_maker/views/add_question.dart';
import 'package:quiz_maker/views/create_quiz.dart';
import 'package:quiz_maker/views/home.dart';
import 'package:quiz_maker/views/signin.dart';
import 'package:quiz_maker/views/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Maker',
      routes: {
        "/signIn": (context) => SignIn(),
        "/singUp": (context) => SignUp(),
        "/home": (context) => Home(),
        "/create_quiz": (context) => CreateQuiz(),
        "/add_question": (context) => AddQuestions(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
