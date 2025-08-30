import 'package:flutter/material.dart';
import '../local_storage/theme_storage.dart';

// *Using Provider for State management
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    String? theme = await ThemeStorage.getTheme();
    debugPrint('theme $theme');
    if (theme == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    debugPrint('Set Theme called');
    _themeMode = mode;
    await ThemeStorage.setTheme(mode);
    notifyListeners();
  }

  void toggleTheme() {
    debugPrint('Toggle Theme called');
    if (_themeMode == ThemeMode.light) {
      setTheme(ThemeMode.dark);
    } else {
      setTheme(ThemeMode.light);
    }
  }
}
