import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/utils/widgets/snackbar_default.dart';

class DioErrorDefault {
  static show(
      {DioError? error, GlobalKey<ScaffoldState>? scaffoldKey, Color? color}) {
    String messageErro = "";
    color = color == null ? Color(0xFFff4d4d) : color;

    print("erro: $error");

    if (error!.message.contains("Connection refused")) {
      messageErro = "Verifique o seu acesso a internet";
    } else if (error.response != null) {
      List<dynamic> errors = error.response.data['errors'];
      messageErro = errors.elementAt(0);
    }

    SnackBarDefault.open(
        scaffoldKey: scaffoldKey!,
        message: messageErro,
        color: color,
        colorText: Colors.white);
  }
}
