import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/controller/auth_controller.dart';
import 'package:skill_swap/model/user_model.dart';
import 'package:skill_swap/utils/local_storage/secure_storage.dart';
import 'package:skill_swap/utils/local_storage/shared_prefs.dart';

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
      await setIsProfileComplete(value: true);
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
    required List<String> wantToLearnSkills,
  }) async {
    loading = true;
    try {
      await AuthController.instance.completeProfile(
        description: description,
        skills: skills,
        wantToLearnSkills: wantToLearnSkills,
      );
      await setIsProfileComplete(value: true);
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

  Future<void> editProfile({
    String? description,
    List<String>? skills,
    List<String>? wantToLearnSkills,
  }) async {
    loading = true;
    try {
      await AuthController.instance.editProfile(
        description: description,
        skills: skills,
        wantToLearnSkills: wantToLearnSkills,
      );
      _user = _user?.copyWith(
        description: description ?? _user?.description,
        skills: skills ?? _user?.skills,
        requestedSkills: wantToLearnSkills ?? _user?.requestedSkills,
      );
      notifyListeners();
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
    }
  }

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
