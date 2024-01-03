import 'package:dio/dio.dart';

class DioNetwork {
  static late Dio dio;
  static void DioInit() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // headers: headrs is const
      ),
    );
  }

  static Future<Response> postData({
    String lang = 'ar',
    String? token,
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization':
          'APRvoLkbDPLOIjL12is90Ys4evOc4hQM5KsVTg0Bf5MQetgLLtjlpbe73yi4bOSd7sHZIu',
    };
    return await dio.post(url, data: data, queryParameters: query);
  }

  static Future<Response> putData({
    String lang = 'ar',
    String? token,
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization':
          'APRvoLkbDPLOIjL12is90Ys4evOc4hQM5KsVTg0Bf5MQetgLLtjlpbe73yi4bOSd7sHZIu',
    };
    return await dio.put(url, data: data, queryParameters: query);
  }

  static Future<Response> getData({
    String lang = 'ar',
    required String token,
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization':
          'APRvoLkbDPLOIjL12is90Ys4evOc4hQM5KsVTg0Bf5MQetgLLtjlpbe73yi4bOSd7sHZIu',
// 'Authorization':token??'',
    };
    return await dio.get(url, queryParameters: query);
  }
}
