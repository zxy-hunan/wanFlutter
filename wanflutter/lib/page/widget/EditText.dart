// ignore: file_names
import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  String hintText = "";
  EditText({Key? key, required this.hintText}) : super(key: key);

  @override
  State<EditText> createState() => _EditTextState(hintText: this.hintText);
}

class _EditTextState extends State<EditText> {
  String hintText;

  _EditTextState({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: TextField(
            decoration: InputDecoration(
                hintText: hintText, border: OutlineInputBorder())));
  }
}
