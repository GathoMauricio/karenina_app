import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDown extends StatelessWidget {
  String hintText;
  List<DropdownMenuItem> listItems;
  DropDown(this.hintText, this.listItems, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20.0, top: 20.0, left: 20.0),
      child: DropdownButtonFormField(
        style: const TextStyle(
          fontSize: 15.0,
          //fontFamily: "Lato",
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
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
        items: listItems,
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }
}
