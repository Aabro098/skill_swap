import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_mts/localization/app_localization.dart';

/// Extension on [BuildContext] providing a shorthand method for localized string translation.
///
/// The [tr] method returns the localized string  using [AppLocalizations].
extension LocalizationExtension on BuildContext {
  /// A method tr() for shorthand of AppLocalizations.of(this)!.translate(key)
  String tr(String key) {
    return AppLocalizations.of(this)!.translate(key);
  }
}
