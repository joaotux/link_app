import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/model/product/product.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';
import 'package:link_app/modules/store/pageable.dart';
import 'package:link_app/utils/colors_default.dart';
import 'package:link_app/utils/widgets/snackbar_default.dart';
import 'package:tuple/tuple.dart';

class ProductRepository {
  late Response _response;

  Future<Product> create(
      Product product, GlobalKey<ScaffoldState> globalKey) async {
    try {
      _response =
          await DioConfig.getDio().post("/product", data: product.toJson());

      if (_response.statusCode == 201) {
        product = Product.fromJson(_response.data);
        globalKey.currentState!.removeCurrentSnackBar();
        SnackBarDefault.open(
            scaffoldKey: globalKey,
            message: "Dados salvos com sucesso",
            color: Color(ColorsDefault.alertInfo));
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: globalKey);
    }
    return product;
  }

  Future<Tuple2<List<Product>, Pageable>> list(
      String query, int currentPage) async {
    List<Product> list = [];
    Pageable? pageable;
    try {
      _response = await DioConfig.getDio()
          .get("/product/list/$query?page=$currentPage");

      for (var p in _response.data['content']) {
        list.add(Product.fromJson(p));
      }

      pageable = Pageable.fromJson(_response.data);
    } catch (e) {
      print("e === $e");
    }
    return Future.value(Tuple2(list, pageable!));
  }

  Future<Product> find(int id) async {
    try {
      _response = await DioConfig.getDio().get("/product/$id");
    } catch (e) {
      print("e === $e");
    }
    return Product.fromJson(_response.data);
  }
}
