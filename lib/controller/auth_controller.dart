import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skill_swap/services/dio_client.dart';
import 'package:skill_swap/services/google_services.dart';
import 'package:skill_swap/utils/constants/api_constants.dart';
import 'package:skill_swap/utils/local_storage/secure_storage.dart';

/// Controller for managing login operations, including Google Sign-In.
/// This class follows the Singleton pattern to ensure a single instance is used throughout the app.
/// It provides methods for signing in with Google and handling the authentication flow.
class AuthController {
  AuthController._();

  /// Singleton instance for the AuthController.
  static final AuthController _instance = AuthController._();

  /// Provides access to the singleton instance.
  static AuthController get instance => _instance;

  /// Handles Google Sign-In authentication flow.
  /// Returns a [Future] that resolves to a [GoogleSignInAccount] if successful.
  /// Throws an [GoogleSignInException] or [Exception] if the sign-in process fails.
  static Future<Map<String, dynamic>> signInGoogle() async {
    final dio = await DioClient.initPublicClient();

    try {
      //* Initialize and Sign In with google
      final serverAuthCode = await GoogleAuthService.signInWithGoogle();

      final formData = {"code": serverAuthCode};

      //* Sending the POST request with FormData and Header
      final response = await dio.post<Map<String, dynamic>>(
        UrlStrings.googleAuth,
        data: formData,
      );

      final data = response.data as Map<String, dynamic>;
      return data;
    } on GoogleSignInException catch (e) {
      debugPrint(
          'GoogleSignInException: code=${e.code.name}, desc=${e.description}');
      rethrow;
    } catch (genericError) {
      debugPrint('Unexpected Error: $genericError');
      rethrow;
    }
  }

  Future<void> completeProfile({
    required String description,
    required List<String> skills,
    required List<String> wantToLearnSkills,
  }) async {
    final dio = await DioClient.initClient();

    try {
      final formData = {
        "description": description,
        "skills": skills,
        "requestedSkills": wantToLearnSkills,
      };

      await dio.put<Map<String, dynamic>>(
        UrlStrings.completeProfile,
        data: formData,
      );
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editProfile({
    String? description,
    List<String>? skills,
    List<String>? wantToLearnSkills,
  }) async {
    final dio = await DioClient.initClient();

    try {
      final formData = {
        if (description != null) "description": description,
        if (skills != null) "skills": skills,
        if (wantToLearnSkills != null) "requestedSkills": wantToLearnSkills,
      };

      await dio.patch<Map<String, dynamic>>(
        UrlStrings.editProfile,
        data: formData,
      );
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    final dio = await DioClient.initClient();

    try {
      //* Sending the GET request
      final response = await dio.get<Map<String, dynamic>>(
        UrlStrings.me,
      );
      final data = response.data as Map<String, dynamic>;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserProfile({required String id}) async {
    final dio = await DioClient.initClient();

    try {
      //* Sending the GET request
      final response = await dio.get<Map<String, dynamic>>(
        "${UrlStrings.user}/$id",
      );
      final data = response.data as Map<String, dynamic>;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    clearToken();
    await GoogleAuthService.instance.disconnect();
  }
}
