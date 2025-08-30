import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  Future<Dio> initClient() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    final Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://api.margintopsolutions.com/api/v1",
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    // Add interceptor to conditionally add Authorization header
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Paths where token should NOT be added
          const noAuthPaths = [
            '/user/login',
            '/user/register',
            '/lawyer/login',
            '/lawyer/register',
            '/user/forgot/password',
            '/lawyer/forgot/password',
          ];

          if (!noAuthPaths.contains(options.path)) {
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            } else {
              debugPrint("The token is empty !!!");
            }
          } else {
            // Remove token header if present on login/signup paths
            options.headers.remove('Authorization');
          }

          return handler.next(options);
        },
        // Add error interceptor to handle responses
        onError: (error, handler) {
          debugPrint("Intercepted error: ${getErrorMessage(error)}");
          return handler.next(error);
        },
      ),
    );

    return dio;
  }

  // Method 1: Return the raw response data
  static dynamic getErrorResponse(DioException e) {
    debugPrint("Dio Error Status Code: ${e.response?.statusCode}");
    debugPrint("Dio Error Response: ${e.response?.data}");

    if (e.response != null) {
      return e.response?.data;
    }

    // For network errors without response
    return {
      'error': e.message ?? "Network error occurred",
      'type': e.type.toString()
    };
  }

  // Method 2: Return error message from API response
  static String getErrorMessage(DioException e) {
    if (e.response != null) {
      final responseData = e.response?.data;

      // If response is a Map and has 'message' key
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        return responseData['message'].toString();
      }

      // If response is a String
      if (responseData is String) {
        return responseData;
      }

      // If response is a Map but no 'message' key, return the whole response as string
      return responseData.toString();
    }

    // Network errors
    return e.message ?? "Network error occurred";
  }

  // Method 3: Return complete error details including response
  static Map<String, dynamic> getErrorDetails(DioException e) {
    return {
      'statusCode': e.response?.statusCode,
      'statusMessage': e.response?.statusMessage,
      'data': e.response?.data,
      'headers': e.response?.headers.map,
      'requestPath': e.requestOptions.path,
      'requestMethod': e.requestOptions.method,
      'type': e.type.toString(),
      'message': e.message,
    };
  }

  // DEPRECATED: Keep for backward compatibility
  static void checkDioError(DioException e) {
    getErrorMessage(e);
  }
}
