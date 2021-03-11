import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/model/company.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';

class AccountRepository {
  Response _response;

  Future<Company> create(
      Company company, GlobalKey<ScaffoldState> globalKey) async {
    try {
      _response =
          await DioConfig.getDio().post("/company", data: company.toJson());

      if (_response.statusCode == 201) {
        company = Company.fromJson(_response.data);
      }
    } on DioError catch (e) {
      DioErrorDefault.show(error: e, scaffoldKey: globalKey);
    }
    return company;
  }
}
