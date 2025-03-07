import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../constants/app_constant.dart';
import '../constants/debug_log.dart';

class ApiClient {
  var logger = Logger();
  final Dio _client;

  ApiClient()
      : _client = Dio(
          BaseOptions(
            sendTimeout: const Duration(milliseconds: 60000),
            receiveTimeout: const Duration(milliseconds: 60000),
            connectTimeout: const Duration(milliseconds: 60000),
            followRedirects: false,
            receiveDataWhenStatusError: true,
          ),
        );

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _client.get(url, queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      DebugLog().printLog('Request get failed: ${e.message}', 'error');
      return null;
    }
  }

  Future<dynamic> post(String url, dynamic payload) async {
    final response = await _client.post(url, data: payload);
    DebugLog().printLog('$response', 'info');
    try {
      return response.data;
    } on DioException catch (e) {
      DebugLog().printLog('Request get failed: ${e.message}', 'error');
      return null;
    }
  }
}
