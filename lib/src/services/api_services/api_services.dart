import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const String _baseUrl = 'https://api.korapay.com/merchant/api/v1';
String? token;

var options = BaseOptions(
  baseUrl: _baseUrl,
);
Dio _dio = Dio(options);

Dio init() {
  Dio dio = _dio;
  // dio.interceptors.add(DioInterceptor());
  dio.options.baseUrl = _baseUrl;
  return dio;
}

class ApiServices {
  ApiServices() {
    init();
  }

  Future post(String endPoint, {required String data}) async {
    try {
      Response response = await _dio.post(
        endPoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          validateStatus: (_) => true,
        ),
        data: data,
      );
      debugPrint("$endPoint Response: ${response.toString()}");
      return response.data;
    } catch (e) {
      debugPrint("Error:-> $e");
      return "error";
    }
  }

  Future chargeCard(String encryptedChargeData) async {
    debugPrint('Charging card . . .');
    return await post(
      '/charges/card',
      data: encryptedChargeData,
    );
  }

  Future authorizeTransaction(String authData) async {
    debugPrint('Authorizing Transaction . . .');
    return await post(
      '/charges/card/authorize',
      data: authData,
    );
  }
}
