import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';

class ForgoutPasswordRepository {
  Dio _dio;
  Response _response;

  ForgoutPasswordRepository() {
    _dio = DioConfig.getDio();
    _response = Response();
  }

  Future<String> forgoutMyPassword(
      String email, GlobalKey<ScaffoldState> scaffoldKey) async {
    String message = "";
    try {
      _response = await _dio.get("/auth/$email");
      if (_response.statusCode == 200) {
        message = _response.data;
      }
    } on DioError catch (e) {
      DioErrorDefault.show(error: e, scaffoldKey: scaffoldKey);
    }
    return message;
  }
}
