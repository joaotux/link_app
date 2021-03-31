import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/model/person/city.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';

class CityRepository {
  Response? _response;

  Future<List<City>> list(
      String uf, String name, GlobalKey<ScaffoldState> globalKey) async {
    List<City> list = [];
    try {
      _response = await DioConfig.getDio().get("/city/$uf/$name");

      if (_response!.statusCode == 200) {
        for (var p in _response!.data) {
          list.add(City.fromJson(p));
        }
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: globalKey);
    }
    return list;
  }
}
