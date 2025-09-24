import 'package:flutter/material.dart';

/// A utility class for managing supported locales in the application.
///
/// Provides a list of supported locales along with their full names,
/// and a helper to retrieve only the `Locale` objects for use in
/// widgets such as `MaterialApp`.
///
/// Supported locales include:
/// - English (en_US)
/// - Nepali (ne_NP)
/// - Català (ca_ES)
/// - Deutsch (de_DE)
/// - Español (es_ES)
/// - Français (fr_FR)
/// - Italiano (it_IT)
///
/// Example usage:
/// ```dart
/// MaterialApp(
///   supportedLocales: LocalizationManager.supportedLocaleList,
/// )
/// ```

class LocalizationManager {
  /// List of supported locales.
  /// Includes: en, ne, de, ja, hi
  static const List<Map<String, dynamic>> supportedLocales = [
    {'locale': Locale('en', 'US'), 'full_name': 'English'},
    {'locale': Locale('ne', 'NP'), 'full_name': 'Nepali'},
    {'locale': Locale('de', 'DE'), 'full_name': 'Deutsch'}, // German
    {'locale': Locale('ja', 'JP'), 'full_name': '日本語'}, // Japanese
    {'locale': Locale('hi', 'IN'), 'full_name': 'हिन्दी'}, // Hindi
  ];

  /// Helper to retrieve only the supported locales for MaterialApp
  static List<Locale> get supportedLocaleList =>
      supportedLocales.map((e) => e['locale'] as Locale).toList();
}
