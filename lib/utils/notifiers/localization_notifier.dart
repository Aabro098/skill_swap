import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/utils/local_storage/localization_storage.dart';

class LocalizationNotifier extends StateNotifier<Locale> {
  LocalizationNotifier() : super(const Locale('en', 'US'));

  /// Load saved locale from SharedPreferences
  Future<void> loadSavedLocale() async {
    final savedLocale = await loadLocaleFromSharedPreference();
    state = savedLocale;
  }

  /// Switch locale and save to SharedPreferences
  Future<void> switchLocale(Locale newLocale) async {
    state = newLocale;
    await saveLocaleToSharedPreference(newLocale);
  }
}

/// Riverpod provider
final localizationProvider =
    StateNotifierProvider<LocalizationNotifier, Locale>((ref) {
  return LocalizationNotifier();
});
