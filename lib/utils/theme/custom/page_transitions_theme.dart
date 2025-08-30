import 'package:flutter/material.dart';

/// Class for Page Transtition Theme with static variable `pageTransitionsTheme`
class AppPageTransitionsTheme {
  AppPageTransitionsTheme._();

  /// Static variable for Page Transitions Theme.
  static const pageTransitionsTheme = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
