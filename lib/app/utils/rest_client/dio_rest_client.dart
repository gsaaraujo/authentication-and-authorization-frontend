import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:authentication_and_authorization_frontend/app/utils/rest_client/interfaces/rest_client.dart';

class DioRestClient implements IRestClient {
  final Dio _dio;

  DioRestClient(this._dio) {
    _dio.options.contentType = 'application/json';
    _dio.options.baseUrl = dotenv.env['VAR_NAME'] ?? '';
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 10000;
  }

  @override
  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.delete(url, options: Options(headers: headers));
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.get(url, options: Options(headers: headers));
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.post(
      url,
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.put(
      url,
      data: data,
      options: Options(headers: headers),
    );
    return response.data;
  }
}
