import 'package:dio/dio.dart';

class DioConfig {
  static Dio _dio;

  static Dio getDio() {
    _dio = Dio();
    _dio.options.baseUrl = "http://10.0.0.192:8080/";
    _dio.options.connectTimeout = 5000; //5s
    _dio.options.receiveTimeout = 3000;
    return _dio;
  }
}
