import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ENDPOINT: ${err.requestOptions.uri}');
    debugPrint('STATUSCODE: ${err.error}');
    debugPrint('MESSAGE: ${err.response?.data ?? err.message}');
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('METHOD: ${options.method}');
    debugPrint('ENDPOINT: ${options.uri}');
    debugPrint('HEADERS: ${options.headers}');
    debugPrint('DATA: ${options.data ?? options.queryParameters}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('ENDPOINT: ${response.requestOptions.uri}');
    debugPrint('STATUSCODE: ${response.statusCode}');
    debugPrint('DATA: ${response.data}');
    super.onResponse(response, handler);
  }
}
