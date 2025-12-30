import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/controller/auth_controller.dart';
import 'package:skill_swap/model/auth_state.dart';
import 'package:skill_swap/model/user_model.dart';
import 'package:skill_swap/services/dio_client.dart';
import 'package:skill_swap/utils/local_storage/secure_storage.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  ///❗️❗️❗️ Methods for LOGIN implementations.

  Future<void> login() async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await AuthController.signInGoogle();

      final token = response['token'] as String;
      await saveTokenSecure(token);

      state = AuthState(
        success: true,
        isAuthenticated: true,
        isProfileComplete: true,
      );
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);

      if (e.response?.statusCode == 400) {
        final token = e.response?.data['token'] as String;
        await saveTokenSecure(token);
        state = AuthState(
          isProfileComplete: false,
          isLoading: false,
          error: errorMessage,
          userId: e.response?.data['userId'] as String?,
        );
      } else {
        state = AuthState(
          isLoading: false,
          error: errorMessage,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Try again.',
      );
    }
  }

  Future<void> completeProfile({
    required String description,
    required List<String> skills,
    required String id,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      await AuthController.instance.completeProfile(
        description: description,
        skills: skills,
        id: id,
      );

      state = AuthState(
        success: true,
        isProfileComplete: true,
      );
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);

      state = AuthState(
        isLoading: false,
        error: errorMessage,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Try again.',
      );
    }
  }

  Future<void> getProfile() async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await AuthController.instance.getUserDetails();
      state = AuthState(
        user: UserModel.fromJson(response),
      );
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);
      state = state.copyWith(isLoading: false, error: errorMessage);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Try again.',
      );
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
      state = AuthState();
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);
      state = state.copyWith(
        error: errorMessage,
        isAuthenticated: false,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isAuthenticated: false,
        error: 'Something went wrong. Try again.',
      );
    }
  }

  /// Reset auth state (used when 401 is received)
  void resetState() {
    state = AuthState();
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  return AuthNotifier();
});
