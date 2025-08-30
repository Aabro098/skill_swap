import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  Future<Dio> initClient() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    debugPrint('Token: $token');

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://api.ot.margintopsolutions.com.np/api/v1",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    return dio;
  }

  static void checkDioError(DioException e) {
    String errorMessage = "An unexpected error occurred"; // Default message

    if (e.response != null) {
      final responseData = e.response?.data;

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        errorMessage = responseData['message'].toString();
      } else {
        errorMessage = "Unexpected response format: ${e.response?.data}";
      }
    } else {
      errorMessage = e.message ?? "Unknown error occurred";
    }

    debugPrint("Dio Error: $errorMessage");

    showErrorSnackbar(errorMessage);
  }
}
