import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_mts/utils/constants/colors.dart';
import 'package:flutter_boilerplate_mts/utils/constants/sizes.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/app_globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Displays an error [SnackBar] with the given [message].
///
/// Optionally, you can specify the display [time] in milliseconds (default is 1000).
/// If [actionMethod] and [actionLabel] are provided, an action button will be shown
/// in the [SnackBar] that triggers [actionMethod] when pressed.
///
/// The [SnackBar] uses [AppColors.error] as its background color and applies
/// padding using [AppSizes.sm] and [AppSizes.md].
///
/// Removes any currently displayed [SnackBar] before showing the new one.
///
/// Example usage:
/// ```dart
/// showErrorSnackbar('An error occurred');
/// showErrorSnackbar(
///   'Failed to save',
///   actionLabel: 'Retry',
///   actionMethod: () { /* retry logic */ },
/// );
/// ```
/// Requires [scaffoldMessengerKey] to be properly initialized and accessible.
void showErrorSnackbar(
  String message, {
  int time = 1000,
  VoidCallback? actionMethod,
  String? actionLabel,
}) {
  scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    backgroundColor: AppColors.error,
    duration: Duration(milliseconds: time),
    padding: const EdgeInsets.symmetric(
      vertical: AppSizes.md,
      horizontal: AppSizes.md,
    ),
    content: Text(message),
    action: (actionMethod != null && actionLabel != null)
        ? SnackBarAction(label: actionLabel, onPressed: actionMethod)
        : null,
  ));
}

/// Displays a success [SnackBar] with the given [message].
///
/// Optionally, you can specify the display [time] in milliseconds (default is 1000).
/// If [actionMethod] and [actionLabel] are provided, an action button will be shown in the snackbar.
///
/// Before showing the new snackbar, any currently displayed snackbar will be hidden.
///
/// Example usage:
/// ```dart
/// showSuccessSnackbar('Operation successful');
/// showSuccessSnackbar(
///   'Item deleted',
///   actionLabel: 'UNDO',
///   actionMethod: () { /* undo logic */ },
/// );
/// ```
///
/// Requires [scaffoldMessengerKey] to be properly initialized and accessible.
void showSuccessSnackbar(
  String message, {
  int time = 1000,
  VoidCallback? actionMethod,
  String? actionLabel,
}) {
  // remove snackbar if any
  scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  // show the snackbar
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: time),
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.md,
        horizontal: AppSizes.md,
      ),
      content: Text(message),
      action: (actionMethod != null && actionLabel != null)
          ? SnackBarAction(label: actionLabel, onPressed: actionMethod)
          : null,
    ),
  );
}

/// Displays an informational [SnackBar] with the given [message].
///
/// Optionally, you can specify the display [time] in milliseconds (default is 1000).
/// If [actionMethod] and [actionLabel] are provided, an action button will be shown
/// in the [SnackBar] that triggers [actionMethod] when pressed.
///
/// The function first hides any currently displayed [SnackBar] before showing the new one.
///
/// Example usage:
/// ```dart
/// showInfoSnackbar('This is an info message');
/// showInfoSnackbar(
///   'Undo action',
///   actionLabel: 'UNDO',
///   actionMethod: () { /* undo logic */ },
/// );
/// ```
/// Requires [scaffoldMessengerKey] to be properly initialized and accessible.
void showInfoSnackbar(
  String message, {
  int time = 1000,
  VoidCallback? actionMethod,
  String? actionLabel,
}) {
  // remove snackbar if any
  scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  // show the snackbar
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: AppColors.info,
      duration: Duration(milliseconds: time),
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.md,
        horizontal: AppSizes.md,
      ),
      content: Text(message),
      action: (actionMethod != null && actionLabel != null)
          ? SnackBarAction(label: actionLabel, onPressed: actionMethod)
          : null,
    ),
  );
}

// function to know if this is first time opening of app
Future<bool> isFirstTimeOpen() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;
  return isFirstTime;
}

// after opening, this is set to knwo this is not first time ofapp opening
Future<void> setIsFirstTimeOpen(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstTime', value);
}

Future<String> getDeviceKey() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  var deviceKey = '{}';

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfoPlugin.androidInfo;
    deviceKey = jsonEncode({
      'serial_number': androidInfo.serialNumber,
      'manufacturer': androidInfo.manufacturer,
      'model': androidInfo.model,
      'version': androidInfo.version.release,
    });
  }

  return deviceKey;
}

/// Checks the device's network connectivity status.
///
/// Returns a [Future] that completes with `true` if the device is connected
/// to a network (excluding VPN and no connectivity), or `false` otherwise.
///
/// This function uses the [Connectivity] package to determine the current
/// connectivity state, filtering out VPN and no connection results.
Future<bool> isConnected() async {
  final results = await Connectivity().checkConnectivity();

  return results.any((result) =>
      result != ConnectivityResult.none && result != ConnectivityResult.vpn);
}
