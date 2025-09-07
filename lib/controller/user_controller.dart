import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skill_swap/services/google_services.dart';

/// Controller for managing login operations, including Google Sign-In.
/// This class follows the Singleton pattern to ensure a single instance is used throughout the app.
/// It provides methods for signing in with Google and handling the authentication flow.
class LoginController {
  LoginController._();

  /// Singleton instance for the LoginController.
  static final LoginController _instance = LoginController._();

  /// Provides access to the singleton instance.
  static LoginController get instance => _instance;

  /// Handles Google Sign-In authentication flow.
  /// Returns a [Future] that resolves to a [GoogleSignInAccount] if successful.
  /// Throws an [GoogleSignInException] or [Exception] if the sign-in process fails.
  static Future<bool?> signInGoogle() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'openid',
    ];
    try {
      //* Initialize and Sign In with google
      final googleUserAccount = await GoogleAuthService.signIn();

      //* Taking the authorization details of User Account
      final userAuthorization = await googleUserAccount.authorizationClient
          .authorizationForScopes(scopes);

      if (userAuthorization == null) {
        return false;
      }

      //* Creating the credential with the access token
      final credential = GoogleSignInClientAuthorization(
        accessToken: userAuthorization.accessToken,
      );

      if (kDebugMode) {
        debugPrint('✅Access Token: ${credential.accessToken}');
        debugPrint('✅Google Account Details:');
        debugPrint('✅Google ID: ${googleUserAccount.id}');
        debugPrint('✅Signed in user: ${googleUserAccount.displayName}');
        debugPrint('✅Email: ${googleUserAccount.email}');
        debugPrint('✅Photo URL: ${googleUserAccount.photoUrl}');
      }

      //* Log in to the backend with the access token
      // final result = await instance._logIn(
      //   provider: 'google',
      //   token: credential.accessToken,
      // );
      return true;
    } on GoogleSignInException catch (e) {
      debugPrint(
          'GoogleSignInException: code=${e.code.name}, desc=${e.description}');
      return false;
    } catch (genericError) {
      debugPrint('Unexpected Error: $genericError');
      return false;
    }
  }

  /// Log In method for sending the `token` from the Google Client to the Backend.
  // Future<bool> _logIn({
  //   required String token,
  //   required String provider,
  // }) async {
  //   final dio = await DioClient().initClient();

  //   try {
  //     //* Creating the Form Data
  //     final formData = FormData.fromMap(
  //       {
  //         'access_token': token,
  //         'provider': provider,
  //       },
  //     );
  //     //* Sending the POST request with FormData and Header
  //     final response = await dio.post<Map<String, dynamic>>(
  //       '/login',
  //       data: formData,
  //     );

  //     //* Successful Response
  //     if (response.statusCode == 200) {
  //       final responseData = response.data;

  //       // Store the token in SharedPreferences
  //       await storeToken(responseData);

  //       // Store the user data in as User Model
  //       storeUserModel(responseData);

  //       // Set the first time open to false
  //       // await setIsFirstTimeOpen(value: false);
  //       return true;
  //     }
  //     debugPrint('❌Login failed: ${response.statusCode}');
  //     return false;
  //   } on DioException catch (e) {
  //     DioClient.checkDioError(e);
  //     return false;
  //   }
  // }

  // Future<void> storeToken(Map<String, dynamic>? responseData) async {
  //   final token = responseData?['token'] as String?;
  //   if (token != null) {
  //     // await setAuthTokenPreference(token: token);
  //     debugPrint('✅Token stored successfully: $token');
  //   } else {
  //     debugPrint('❌No token received from the server.');
  //   }
  // }

  // void storeUserModel(Map<String, dynamic>? responseData) async {
  //   final userData = responseData?['user'] as Map<String, dynamic>?;
  //   if (userData != null) {
  //     // Create a UserModel instance from the user data
  //     // final user = UserModel.fromMap(userData);

  //     // Store the user model in UserProvider
  //     // Provider.of<UserProvider>(scaffoldMessengerKey.currentContext!,
  //     //         listen: false)
  //     //     .setUser(user);
  //     debugPrint('✅User data stored in UserProvider.');

  //     // Store the user model in SharedPreferences
  //     // await setUserPreference(user);
  //     // debugPrint('✅User data stored successfully and cached: ${user.name}');
  //   } else {
  //     debugPrint('❌No user data received from the server.');
  //   }
  // }

  // Future<void> logOut() async {
  //   final token = await getAuthTokenPreference();
  //   // if token is not null, then try to logout from backend.
  //   if (token != null) {
  //     final dio = await DioClient.initClient();

  //     final formData = FormData.fromMap({});
  //     try {
  //       final response = await dio.post(
  //         '/user/logout',
  //         data: formData,
  //       );
  //       if (response.statusCode == 200) {
  //         debugPrint('✅ User Logged Out successfully from backend.');
  //       }
  //     } on DioException catch (e) {
  //       DioClient.checkDioError(e);
  //     }
  //   }
  // }

  // Future<void> deleteAccount() async {
  //   final token = await getAuthTokenPreference();

  //   if (token != null) {
  //     final dio = await DioClient.initClient();

  //     try {
  //       final response = await dio.delete(
  //         '/user/delete',
  //       );
  //       if (response.statusCode == 200) {
  //         debugPrint('✅ User Account Deleted successfully from backend.');
  //       }
  //     } on DioException catch (e) {
  //       DioClient.checkDioError(e);
  //     }
  //   }
  // }
}
