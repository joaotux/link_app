import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/model/person/states.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';

class StateRepository {
  Response? _response;

  Future<List<States>> list(
      String name, GlobalKey<ScaffoldState> globalKey) async {
    List<States> list = [];
    try {
      _response = await DioConfig.getDioWithToken().get("/state/$name");

      if (_response!.statusCode == 200) {
        for (var p in _response!.data) {
          list.add(States.fromJson(p));
        }
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: globalKey);
    }
    return list;
  }

  Future<States> find(String uf, GlobalKey<ScaffoldState> globalKey) async {
    States state = States();
    try {
      _response = await DioConfig.getDioWithToken().get("/state/uf/$uf");

      if (_response!.statusCode == 200) {
        state = States.fromJson(_response!.data);
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: globalKey);
    }
    return state;
  }
}
