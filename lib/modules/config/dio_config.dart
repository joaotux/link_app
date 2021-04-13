import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:link_app/utils/token_utils.dart';

class DioConfig {
  static Dio _dio = Dio();
  static final _tokenUtils = GetIt.I.get<TokenUtils>();
  static const String _URL = 'http://10.0.0.193:8080/';

  static Dio getDio() {
    _dio.options.baseUrl = _URL;
    _dio.options.connectTimeout = 5000; //5s
    _dio.options.receiveTimeout = 3000;
    return _dio;
  }

  static Dio getDioWithToken() {
    getDio();
    _dio.options.headers = {"Authorization": _tokenUtils.token};
    return _dio;
  }
}
