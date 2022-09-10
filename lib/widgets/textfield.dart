import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  String hint;
  bool hide;

  Textfield({
    required this.hint,
    required this.hide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        obscureText: hide,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white60,
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade400, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade400, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
