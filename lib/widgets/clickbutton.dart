import 'package:flutter/material.dart';

class clickbutton extends StatelessWidget {
  Color color;
  String text;
  Color textcolor;
  var fun;

  clickbutton(
      {required this.color,
      required this.text,
      required this.textcolor,
      required this.fun});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(15)),
          child: TextButton(
              onPressed: fun,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: textcolor,
                ),
              ))),
    );
  }
}
