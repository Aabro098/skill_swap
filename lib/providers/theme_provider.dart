import 'package:flutter/material.dart';
import '../utils/local_storage/theme_storage.dart';

// *Using Provider for State management
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    String? theme = await ThemeStorage.getTheme();
    if (theme == 'light') {
      _themeMode = ThemeMode.light;
    } else if (theme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;
    await ThemeStorage.setTheme(mode);
    notifyListeners();
  }
}
