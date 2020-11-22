import 'package:flutter/material.dart';
import 'package:quiz_maker/helper/helper_functions.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  Auth auth = new Auth();

  bool isLoading = false;

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await auth.signIn(email, password).then((value) {
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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : _signInBody(),
    );
  }

  Widget _signInBody() {
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
                  SizedBox(height: 6),
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
                    child: Text("Sign in"), 
                    onPressed: () {
                      HelperFunctions.saveUser(isLoggedIn: true);
                      signIn();
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
                      "Are not register yet?",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/signUp");
                      },
                      child: Text(
                        "Sign up",
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
