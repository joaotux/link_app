import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:link_app/model/product/product.dart';
import 'package:link_app/modules/config/dio_config.dart';
import 'package:link_app/modules/config/dio_error_defalt.dart';

class ProductRepository {
  Response _response;

  Future<Product> create(
      Product product, GlobalKey<ScaffoldState> globalKey) async {
    try {
      _response =
          await DioConfig.getDio().post("/product", data: product.toJson());

      if (_response.statusCode == 201) {
        product = Product.fromJson(_response.data);
      }
    } on DioError catch (e) {
      print("error ============= $e");
      DioErrorDefault.show(error: e, scaffoldKey: globalKey);
    }
    return product;
  }
}
