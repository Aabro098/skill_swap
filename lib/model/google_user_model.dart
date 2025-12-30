import 'package:google_sign_in/google_sign_in.dart';

class GoogleUser {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;

  GoogleUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  factory GoogleUser.fromAccount(GoogleSignInAccount account) {
    return GoogleUser(
      id: account.id,
      name: account.displayName ?? '',
      email: account.email,
      photoUrl: account.photoUrl,
    );
  }
}
