import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/model/provider.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';

class ProviderRepository {
  Response? _response;

  Future<List<Provider>> list(
      String name, GlobalKey<ScaffoldState> globalKey) async {
    List<Provider> list = [];
    try {
      _response = await DioConfig.getDio().get(
        "/provider/$name",
      );

      if (_response!.statusCode == 200) {
        for (var p in _response!.data) {
          list.add(Provider.fromJson(p));
        }
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: globalKey);
    }
    return list;
  }
}
