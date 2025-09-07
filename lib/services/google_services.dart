import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      clientId:
          '876834940207-0aovtrp2ufcn0fketfpepgcmdassq9jb.apps.googleusercontent.com',
      serverClientId:
          '876834940207-vkps1di57aot54n6gustdjsdc81d73rs.apps.googleusercontent.com',
    );

    _isInitialized = true;
    debugPrint('✅ GoogleAuthService Initialization completed.');
  }

  /// Initializes the Google Sign-In service and triggers user authentication.
  ///
  /// Returns a [GoogleSignInAccount] on successful authentication.
  /// Throws an [GoogleSignInException] or [Exception] if sign-in fails.
  static Future<GoogleSignInAccount> signIn() async {
    try {
      await instance._initialize();

      final account = await instance._googleSignIn.authenticate();
      debugPrint('✅ GoogleAuthService User authenticated: $account');

      return account;
    } on GoogleSignInException catch (e) {
      debugPrint(
          '❌ GoogleAuthService Sign-In failed.\n Code: ${e.code},\n Description: ${e.description}');
      throw Exception('Google Sign-In failed: ${e.code}');
    } catch (e) {
      debugPrint('GoogleAuthService → Unexpected error: $e');
      throw Exception('Unexpected error during Google Sign-In.');
    }
  }
}
