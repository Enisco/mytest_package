import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mytest_package/src/services/api_services/api_interceptors.dart';

const String _baseUrl = 'https://api.korapay.com/merchant/api/v1';

var options = BaseOptions(
  baseUrl: _baseUrl,
);
Dio _dio = Dio(options);

Dio init() {
  Dio dio = _dio;
  dio.interceptors.add(DioInterceptor());
  dio.options.baseUrl = _baseUrl;
  return dio;
}

class ApiServices {
  ApiServices() {
    init();
  }

  Future chargeCard(String encryptedChargeData) async {
    debugPrint('Charging card . . .');
    try {
      Response response = await _dio.post(
        '/charges/card',
        options: Options(
          validateStatus: (_) => true,
        ),
        data: {
          "charge_data": encryptedChargeData,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        return "error";
      }
    } catch (e) {
      debugPrint("Error:-> $e");
      return "error";
    }
  }
}
