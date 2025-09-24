import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../local_storage/theme_storage.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  Future<void> loadTheme() async {
    final theme = await ThemeStorage.getTheme();
    debugPrint('theme $theme');
    if (theme == 'light') {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    debugPrint('Set Theme called');
    state = mode;
    await ThemeStorage.setTheme(mode);
  }

  void toggleTheme() {
    debugPrint('Toggle Theme called');
    if (state == ThemeMode.light) {
      setTheme(ThemeMode.dark);
    } else {
      setTheme(ThemeMode.light);
    }
  }
}

// Riverpod provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);
