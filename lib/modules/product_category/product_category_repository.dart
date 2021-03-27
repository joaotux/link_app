import 'package:dio/dio.dart';
import 'package:link_app/model/product/product_category.dart';
import 'package:link_app/modules/config/dio_config.dart';

class ProductCategoryRepository {
  late Response _response;

  Future<List<ProductCategory>> list() async {
    List<ProductCategory> list = [];
    try {
      _response = await DioConfig.getDio().get("/product-category");
      if (_response.statusCode == 200) {
        for (var pc in _response.data) {
          list.add(ProductCategory.fromJson(pc));
        }
      }
    } catch (e) {
      print("error ======= $e");
    }
    return list;
  }
}
