import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInResult {
  GoogleSignInResult({this.account, this.serverAuthCode});
  final GoogleSignInAccount? account;
  final String? serverAuthCode;
}

/// Handles Google Sign-In authentication logic.
/// Supports initialization, sign-in, and additional scope authorization.
class GoogleAuthService {
  /// Private constructor to prevent instantiation.
  GoogleAuthService._();

  /// Singleton instance for managing Google sign-in.
  static final GoogleAuthService _instance = GoogleAuthService._();

  /// Getter that provides access to the singleton instance.
  static GoogleAuthService get instance => _instance;

  //* Attirbutes
  /// Google Sign-In client instance.
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  /// Indicates if the service has been initialized.
  bool _isInitialized = false;

  //*Getters
  /// Getter for Sign-In client instance.
  GoogleSignIn get googleSignIn => _googleSignIn;

  /// Getter for checkign if service has been initialized.
  bool get isInitialized => _isInitialized;

  //* Methods
  /// Initializes the Google Sign-In client with provided configuration.
  Future<void> _initialize() async {
    if (_isInitialized) return;

    await _googleSignIn.initialize(
      serverClientId:
          "380679229848-1b9qkh2qdr4e45nfejq31v15lc2ds5iu.apps.googleusercontent.com",
    );

    _isInitialized = true;
    debugPrint('✅ GoogleAuthService Initialization completed.');
  }

  /// Initializes the Google Sign-In service and triggers user authentication.
  ///
  /// Returns a [GoogleSignInAccount] on successful authentication.
  /// Throws an [GoogleSignInException] or [Exception] if sign-in fails.
  static Future<String?> signInWithGoogle() async {
    final scopes = ['email', 'openid', 'profile'];
    try {
      //* Initialize and Sign In with google
      await instance._initialize();
      final account = await instance._googleSignIn.authenticate(
        scopeHint: scopes,
      );
      debugPrint('✅ GoogleAuthService User authenticated: $account');

      //* Requesting server authorization code
      final serverAuthorization =
          await account.authorizationClient.authorizeServer(scopes);
      final serverAuthCode = serverAuthorization?.serverAuthCode;

      if (serverAuthCode == null || serverAuthCode.isEmpty) {
        debugPrint(
          'serverAuthCode is null',
        );
      }

      if (kDebugMode) {
        debugPrint('✅Google Account Details:');
        debugPrint('✅Google ID: ${account.id}');
        debugPrint('✅Signed in user: ${account.displayName}');
        debugPrint('✅Email: ${account.email}');
        debugPrint('✅Server Auth Code: $serverAuthCode');
      }

      return serverAuthCode;
    } on GoogleSignInException catch (e) {
      debugPrint(
        '❌ GoogleSignInException: code=${e.code}, desc=${e.description}',
      );
      final result = e.description!.split('] ')[1];
      debugPrint(result);
      rethrow;
    } catch (genericError) {
      debugPrint('Unexpected Error: $genericError');
      rethrow;
    }
  }

  Future<void> disconnect() async {
    await GoogleAuthService.instance.googleSignIn.disconnect();
  }
}
