import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/utils/token_utils.dart';

class DioConfig {
  static Dio _dio = Dio();
  static final _tokenUtils = GetIt.I.get<TokenUtils>();

  static Dio getDio() {
    _dio.options.baseUrl = "http://10.0.0.192:8080/";
    _dio.options.connectTimeout = 5000; //5s
    _dio.options.receiveTimeout = 3000;
    _dio.options.headers = {"Authorization": _tokenUtils.token};
    return _dio;
  }
}
