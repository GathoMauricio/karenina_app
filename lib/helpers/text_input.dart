import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  bool isPassword = false;
  int maxLines = 1;

  TextInput(this.hintText, this.inputType, this.controller, this.maxLines,
      this.isPassword,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20.0, top: 20.0, left: 20.0),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        style: const TextStyle(
            fontSize: 15.0,
            //fontFamily: "Lato",
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFe5e5e5),
            border: InputBorder.none,
            hintText: hintText,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFe5e5e5)),
                borderRadius: BorderRadius.all(Radius.circular(9.0))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFe5e5e5)),
                borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }
}
