import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ErrENDPOINT: ${err.requestOptions.uri}');
    debugPrint('ErrSTATUSCODE: ${err.error}');
    debugPrint('ErrMESSAGE: ${err.response?.data ?? err.message}');
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('reqMETHOD: ${options.method}');
    debugPrint('reqENDPOINT: ${options.uri}');
    debugPrint('reqHEADERS: ${options.headers}');
    debugPrint('reqDATA: ${options.data ?? options.queryParameters}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('resENDPOINT: ${response.requestOptions.uri}');
    debugPrint('resSTATUSCODE: ${response.statusCode}');
    debugPrint('resDATA: ${response.data}');
    super.onResponse(response, handler);
  }
}
