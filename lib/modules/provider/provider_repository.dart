import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/model/provider.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';
import 'package:link_app/modules/provider/provider_dto.dart';
import 'package:link_app/modules/store/pageable.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/widgets/snackbar_default.dart';
import 'package:tuple/tuple.dart';

class ProviderRepository {
  Response? _response;

  Future<List<ProviderDTO>> list(
      String name, bool active, GlobalKey<ScaffoldState> globalKey) async {
    List<ProviderDTO> list = [];
    try {
      _response = await DioConfig.getDioWithToken().get(
        "/provider/list-no-page/$name/$active",
      );

      if (_response!.statusCode == 200) {
        for (var p in _response!.data) {
          list.add(ProviderDTO.fromJson(p));
        }
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: globalKey);
    }
    return list;
  }

  Future<Tuple2<List<ProviderDTO>, Pageable>> listPage(String name, bool active,
      int currentPage, GlobalKey<ScaffoldState> globalKey) async {
    List<ProviderDTO> list = [];
    Pageable? pageable;
    try {
      _response = await DioConfig.getDioWithToken().get(
        "/provider/list/$name/$active?page=$currentPage",
      );

      if (_response!.statusCode == 200) {
        for (var p in _response!.data['content']) {
          list.add(ProviderDTO.fromJson(p));
        }
        pageable = Pageable.fromJson(_response!.data);
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: globalKey);
    }
    return Future.value(Tuple2(list, pageable!));
  }

  Future<Provider> create(
      Provider provider, GlobalKey<ScaffoldState> key) async {
    try {
      _response = await DioConfig.getDioWithToken()
          .post("/provider", data: provider.toJson());

      if (_response!.statusCode == 201) {
        provider = Provider.fromJson(_response!.data);
        key.currentState!.removeCurrentSnackBar();
        SnackBarDefault.open(
            scaffoldKey: key,
            message: "Dados salvos com sucesso",
            color: Color(ColorsDefault.alertInfo));
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: key);
    }
    return provider;
  }

  Future<Provider> alter(
      int id, Provider provider, GlobalKey<ScaffoldState> key) async {
    try {
      _response = await DioConfig.getDioWithToken()
          .put("/provider/$id", data: provider.toJson());

      if (_response!.statusCode == 200) {
        provider = Provider.fromJson(_response!.data);
        key.currentState!.removeCurrentSnackBar();
        SnackBarDefault.open(
            scaffoldKey: key,
            message: "Dados salvos com sucesso",
            color: Color(ColorsDefault.alertInfo));
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: key);
    }
    return provider;
  }

  Future<Provider> find(id, GlobalKey<ScaffoldState> key) async {
    late Provider provider;

    try {
      _response = await DioConfig.getDioWithToken().get("/provider/$id");

      if (_response!.statusCode == 200) {
        provider = Provider.fromJson(_response!.data);
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: key);
    }
    return provider;
  }

  Future delete(id, GlobalKey<ScaffoldState> key) async {
    try {
      _response = await DioConfig.getDioWithToken().delete("/provider/$id");
      if (_response!.statusCode == 200) {}
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: key);
    }
  }
}
