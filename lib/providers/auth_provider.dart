import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/controller/auth_controller.dart';
import 'package:skill_swap/model/user_model.dart';
import 'package:skill_swap/utils/local_storage/secure_storage.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? _user;
  UserModel? get user => _user;

  set loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ///❗️❗️❗️ Methods for LOGIN implementations.
  Future<void> login() async {
    loading = true;
    try {
      final response = await AuthController.signInGoogle();
      final token = response['token'] as String;
      await saveTokenSecure(token);
      return;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
    }
  }

  Future<void> completeProfile({
    required String description,
    required List<String> skills,
  }) async {
    loading = true;
    try {
      await AuthController.instance.completeProfile(
        description: description,
        skills: skills,
      );
      return;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
    }
  }

  Future<UserModel?> getProfile() async {
    try {
      final response = await AuthController.instance.getUserDetails();
      final user = UserModel.fromJson(response);
      _user = user;
      notifyListeners();
      return user;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> editProfile({File? imageFile, String? name}) async {
  //   state = state.copyWith(isLoading: true);

  //   try {
  //     final response = await AuthController.instance.editProfile(
  //       imageFile: imageFile,
  //       name: name,
  //     );
  //     final user = response['user'] as Map<String, dynamic>;
  //     final avatar = user['avatar'] as Map<String, dynamic>;
  //     state = AuthState(
  //       success: true,
  //       user: UserModel(
  //         name: user['name'] as String,
  //         email: user['email'] as String,
  //         avatarUrl: avatar['url'] as String,
  //       ),
  //       isAuthenticated: true,
  //     );
  //   } on DioException catch (e) {
  //     final errorMessage = DioClient.parseDioError(e);
  //     state = state.copyWith(isLoading: false, error: errorMessage);
  //   } catch (e) {
  //     state = state.copyWith(
  //       isLoading: false,
  //       error: 'Something went wrong. Try again.',
  //     );
  //   }
  // }

  Future<void> logout() async {
    try {
      await AuthController.instance.logOut();
      return;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
