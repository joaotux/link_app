import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/model/service.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';
import 'package:link_app/modules/store/pageable.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/widgets/snackbar_default.dart';
import 'package:tuple/tuple.dart';

class ServiceRepository {
  late Response _response;
  late Dio _dio;
  static final String _URL = "/service";

  ServiceRepository() {
    _dio = DioConfig.getDioWithToken();
  }

  Future<Tuple2<List<Service>, Pageable>> list(String description, bool active,
      int currentPage, GlobalKey<ScaffoldState> key) async {
    List<Service> list = [];
    Pageable? pageable;
    try {
      _response =
          await _dio.get("$_URL/list/$description/$active?page=$currentPage");
      if (_response.statusCode == 200) {
        for (var data in _response.data['content']) {
          list.add(Service.fromJson(data));
        }
        pageable = Pageable.fromJson(_response.data);
      }
    } on DioError catch (e) {
      DioErrorDefault.show(error: e, scaffoldKey: key);
    }
    return Future.value(Tuple2(list, pageable!));
  }

  Future<Service> create(Service service, GlobalKey<ScaffoldState> key) async {
    try {
      _response = await _dio.post("$_URL", data: service.toJson());
      if (_response.statusCode == 200) {
        service = Service.fromJson(_response.data);
        SnackBarDefault.open(
            scaffoldKey: key,
            message: "Serviço salvo com sucesso",
            color: Color(ColorsDefault.alertInfo));
      }
    } on DioError catch (e) {
      DioErrorDefault.show(error: e, scaffoldKey: key);
    }
    return service;
  }

  Future<Service> find(int id, GlobalKey<ScaffoldState> key) async {
    Service service = Service();
    try {
      _response = await _dio.get("$_URL/$id");
      if (_response.statusCode == 200) {
        service = Service.fromJson(_response.data);
      }
    } on DioError catch (e) {
      DioErrorDefault.show(error: e, scaffoldKey: key);
    }
    return service;
  }

  Future delete(int id, GlobalKey<ScaffoldState> key) async {
    try {
      await _dio.delete('$_URL/$id');
    } on DioError catch (e) {
      DioErrorDefault.show(error: e, scaffoldKey: key);
    }
  }

  Future<Service> alter(
      int id, Service service, GlobalKey<ScaffoldState> key) async {
    try {
      _response = await _dio.put("$_URL/$id", data: service.toJson());
      if (_response.statusCode == 200) {
        service = Service.fromJson(_response.data);
        SnackBarDefault.open(
            scaffoldKey: key,
            message: "Serviço salvo com sucesso",
            color: Color(ColorsDefault.alertInfo));
      }
    } on DioError catch (e) {
      DioErrorDefault.show(error: e, scaffoldKey: key);
    }
    return service;
  }
}
