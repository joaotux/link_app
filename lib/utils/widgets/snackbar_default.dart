import 'package:flutter/material.dart';

class SnackBarDefault {
  static void open(
      {required GlobalKey<ScaffoldState> scaffoldKey,
      required String message,
      Color? color,
      Color? colorText}) {
    color = color == null ? Color(0xFFcccccc) : color;
    colorText = colorText == null ? Colors.black : colorText;
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: colorText),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      margin: EdgeInsets.only(right: 15, left: 15),
    ));
  }
}
