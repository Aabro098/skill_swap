import 'package:shared_preferences/shared_preferences.dart';

/// After opening, this is set to know this is not first time of app opening
Future<void> setIsFirstTimeOpen({required bool value}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstTime', value);
}

/// Function to know if this is first time opening of app
Future<bool> isFirstTimeOpen() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;
  return isFirstTime;
}

Future<void> setIsProfileComplete({required bool value}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isProfileComplete', value);
}

/// Function to know if user has completed profile
Future<bool> isProfileComplete() async {
  final prefs = await SharedPreferences.getInstance();
  final isProfileComplete = prefs.getBool('isProfileComplete') ?? false;
  return isProfileComplete;
}
