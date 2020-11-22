import 'package:flutter/material.dart';

Widget appBar() {
  return RichText(
    text: TextSpan(
      text: 'Quiz',
      style: TextStyle(
        fontSize: 20,
        color: Colors.black87,
      ),
      children: <TextSpan>[
        TextSpan(text: 'maker', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
