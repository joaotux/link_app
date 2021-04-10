import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/model/Token.dart';
import 'package:link_app/model/user.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';
import 'package:link_app/utils/widgets/snackbar_default.dart';

class LoginRepository {
  Dio _dio = DioConfig.getDio();
  late Response _response;

  LoginRepository() {
    _response = Response();
  }

  Future<Token> login(String email, String password,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    Token token = Token();

    User user = User(email: email, password: password);

    try {
      _response = await _dio.post("/login", data: user.toJsonLogin());
      print('_response.statusCode ==== ${_response.statusCode}');
      print('headers ==== ${_response.headers.value('authorization')}');

      if (_response.statusCode == 200) {
        String value = _response.headers.value('authorization');
        token = Token(token: value);
      }
    } on DioError catch (e) {
      print('e 1 ==== ${e.message}');

      if (e.message.contains("403")) {
        SnackBarDefault.open(
            scaffoldKey: scaffoldKey,
            message: "E-mail ou senha inválidos",
            color: Color(0xFFff4d4d),
            colorText: Colors.white);
      } else {
        DioErrorDefault.show(error: e, scaffoldKey: scaffoldKey);
      }
    }
    return token;
  }
}
