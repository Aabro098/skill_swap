import 'package:flutter/material.dart';
import 'package:skill_swap/localization/app_localization.dart';

/// Extension on [BuildContext] providing a shorthand method for localized string translation.
///
/// The [tr] method returns the localized string  using [AppLocalizations].
extension LocalizationExtension on BuildContext {
  /// A method tr() for shorthand of AppLocalizations.of(this)!.translate(key)
  String tr(String key) {
    return AppLocalizations.of(this)!.translate(key);
  }

  /// Extension on [BuildContext] to provide shorthand access to the Theme.

  /// Shortcut for `Theme.of(context)`
  ThemeData get theme => Theme.of(this);

  /// Shortcut for `Theme.of(context).textTheme`
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Shortcut for `Theme.of(context).colorScheme`
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
