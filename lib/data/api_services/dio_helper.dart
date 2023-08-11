

import 'package:dio/dio.dart';
import 'package:mini_store/data/api_services/end_points.dart';
import 'package:mini_store/shared/global_value.dart';

class DioHelper
{
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      receiveDataWhenStatusError: true,
    ),
  );

  static late DioHelper dioHelper;

  @override
  Future<Response> postData({
    required String url,
    required dynamic data,
    String? token,
  }) async {
    _dio.options.headers = {
      'lang': LANG.name,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await _dio.post(
      url,
      data: data,
    );
  }

  @override
  Future<Response> putData({
    required String url,
    required dynamic data,
    String? token,
  }) async {
    _dio.options.headers = {
      'lang': LANG.name,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await _dio.put(
      url,
      data: data,
    );
  }

  @override
  Future<Response> getData({
    required String url,
    dynamic query,
    String? token,
  }) async {
    _dio.options.headers = {
      'lang': LANG.name,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await _dio.get(
      url,
      queryParameters: query,
    );
  }
}