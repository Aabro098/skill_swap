import 'package:flutter/material.dart';
import 'package:skill_swap/localization/app_localization.dart';
import 'package:skill_swap/utils/device/device_utility.dart';

/// Extension on [BuildContext] providing shorthand methods for localization,
/// theme access, and gradients.
extension AppContextExtension on BuildContext {
  // -------------------------------
  // Localization
  // -------------------------------
  /// Shortcut for localized strings
  String tr(String key) {
    return AppLocalizations.of(this)!.translate(key);
  }

  // -------------------------------
  // Theme shortcuts
  // -------------------------------
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // -------------------------------
  // Gradient shortcuts
  // -------------------------------
  /// Returns a primary vertical gradient, adapted to dark mode
  LinearGradient get gradient {
    final isDarkMode = DeviceUtility.isDarkMode(this);

    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.deepPurple.shade200,
        Colors.deepPurple.shade300,
        isDarkMode ? Colors.black : Colors.white,
      ],
      stops: const [0.0, 0.2, 0.6],
    );
  }

  /// Returns the screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isDarkMode => DeviceUtility.isDarkMode(this);
}
