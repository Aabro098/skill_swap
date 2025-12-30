import 'package:skill_swap/model/user_model.dart';

class AuthState {
  AuthState({
    this.user = const UserModel(
        name: '',
        email: '',
        id: '',
        description: '',
        profileUrl: '',
        skills: [],
        isPremiumUser: false),
    this.isLoading = false,
    this.success = false,
    this.error,
    this.isAuthenticated = false,
    this.isProfileComplete = true,
    this.userId,
  });
  final UserModel user;
  final bool isLoading;
  final bool success;
  final String? error;
  final bool isAuthenticated;
  final bool isProfileComplete;
  final String? userId;

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    bool? success,
    String? error,
    bool? isAuthenticated,
    bool? isProfileComplete,
    String? userId,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      userId: userId ?? this.userId,
    );
  }
}
