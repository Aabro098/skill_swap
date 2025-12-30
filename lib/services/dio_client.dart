import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/notifiers/auth_notifier.dart';
import 'package:skill_swap/screens/Auth/login_screen.dart';
import 'package:skill_swap/utils/constants/api_constants.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';
import 'package:skill_swap/utils/local_storage/secure_storage.dart';

ProviderContainer? _providerContainer;

void setProviderContainer(ProviderContainer container) {
  _providerContainer = container;
}

/// Class for Using the DioClient for managing HTTP networking.
class DioClient {
  DioClient._();

  //! ALWAYS USE  '_method': 'DELETE' OR 'PUT' inside data.
  //* Eg.
  //*  final formData = FormData.fromMap({
  //* '_method': 'DELETE',
  //* });
  //* final response = await dio.post('/user/delete', data: formData);

  /// Initialize the Dio Client with default parameters.
  static Future<Dio> initClient() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: UrlStrings.baseUrl,
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        headers: {
          // 'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(AuthInterceptor());
    return dio;
  }

  /// Initialize the Dio Client for public access without authentication (like for login).
  static Future<Dio> initPublicClient() async {
    return Dio(
      BaseOptions(
        baseUrl: UrlStrings.baseUrl,
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        headers: {
          // 'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static String parseDioError(DioException e) {
    final response = e.response;
    if (response != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      final message = data['message']?.toString() ?? 'Unknown server error';

      final errors = data['errors'];
      if (errors != null) {
        if (errors is Map<String, dynamic>) {
          final buffer = StringBuffer();
          errors.forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              buffer.writeln(value.join(', '));
            } else {
              buffer.writeln('$key: $value');
            }
          });
          return '$message\n${buffer.toString().trim()}';
        } else if (errors is List) {
          final buffer = StringBuffer();
          for (final e in errors) {
            if (e is Map<String, dynamic>) {
              final msgs = (e['message'] as List<dynamic>?)?.join(', ') ?? '';
              buffer.writeln(msgs);
            }
          }
          return '$message\n${buffer.toString().trim()}';
        }
      }

      return message;
    }
    return e.message ?? 'No response received';
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getTokenSecure();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 403) {
      // Clear auth token
      await clearToken();

      // Reset auth state
      _providerContainer?.read(authNotifierProvider.notifier).resetState();

      // Navigate to login safely
      await navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginScreen.routeName,
        (_) => false,
      );
    }

    handler.next(err); // IMPORTANT: continue error propagation
  }
}
