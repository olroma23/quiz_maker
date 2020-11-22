import 'package:flutter/material.dart';
import 'package:quiz_maker/helper/helper_functions.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;
  Auth auth = new Auth();

  bool isLoading = false;

  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      auth.signUp(email, password).then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
            Navigator.pushReplacementNamed(context, "/home");
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: (CircularProgressIndicator()),
              ),
            )
          : _signUpBody(),
    );
  }

  Widget _signUpBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Spacer(),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: "Name",
                      icon: Icon(Icons.person),
                      filled: true,
                    ),
                    validator: (value) {
                      return value.isEmpty ? "Enter correct name" : null;
                    },
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: "Email",
                      icon: Icon(Icons.email),
                      filled: true,
                    ),
                    validator: (value) {
                      return value.isEmpty ? "Enter correct email" : null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: "Password",
                      icon: Icon(Icons.lock),
                      filled: true,
                    ),
                    obscureText: true,
                    validator: (value) {
                      return value.isEmpty ? "Enter correct password" : null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: 14),
                  RaisedButton(
                    child: Text("Sign up"),
                    onPressed: () {
                      HelperFunctions.saveUser(isLoggedIn: true);
                      signUp();
                    },
                    color: Colors.indigo,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/signIn");
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
