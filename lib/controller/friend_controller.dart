import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/services/dio_client.dart';
import 'package:skill_swap/utils/constants/api_constants.dart';

class FriendController {
  FriendController._();

  /// Singleton instance for the FriendController.
  static final FriendController _instance = FriendController._();

  /// Provides access to the singleton instance.
  static FriendController get instance => _instance;

  Future<Map<String, dynamic>> getRecommendedUsers() async {
    final dio = await DioClient.initClient();

    try {
      final response = await dio.post<Map<String, dynamic>>(
        UrlStrings.recommendedUsers,
      );
      final data = response.data as Map<String, dynamic>;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> sendRequest({required String id}) async {
    final dio = await DioClient.initClient();

    final reqData = {
      'toUserId': id,
    };

    try {
      final response = await dio.post<Map<String, dynamic>>(
        UrlStrings.sendRequest,
        data: reqData,
      );
      final data = response.data as Map<String, dynamic>;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> sentRequests() async {
    final dio = await DioClient.initClient();

    try {
      final response = await dio.get<Map<String, dynamic>>(
        UrlStrings.sentRequests,
      );
      final data = response.data as Map<String, dynamic>;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRequests() async {
    final dio = await DioClient.initClient();

    try {
      final response = await dio.get<Map<String, dynamic>>(
        UrlStrings.friendRequests,
      );
      final data = response.data as Map<String, dynamic>;

      return data;
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);
      debugPrint(errorMessage);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> friends() async {
    final dio = await DioClient.initClient();

    try {
      final response = await dio.get<Map<String, dynamic>>(
        UrlStrings.friends,
      );
      final data = response.data as Map<String, dynamic>;

      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> respondRequest({required String userId}) async {
    final dio = await DioClient.initClient();

    try {
      final reqData = {
        "userId": userId,
      };
      final response = await dio.put<Map<String, dynamic>>(
        UrlStrings.respond,
        data: reqData,
      );
      final data = response.data as Map<String, dynamic>;
      return data;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
