import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Provides utilities for initializing and managing background services and local notifications
/// on Android and iOS platforms. Handles notification channel setup, permission requests,
/// and periodic device info updates to the background service.
class BackgroundServices {
  /// Initializes local notifications for Android and iOS platforms.
  /// Sets up a custom notification channel for foreground services on Android.
  /// Requests notification permissions where necessary.
  Future<void> init() async {
    /// OPTIONAL, using custom notification channel id
    const channel = AndroidNotificationChannel(
      'my_foreground', // id
      'MY FOREGROUND SERVICE', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.low, // importance must be at low or higher level
    );
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      unawaited(flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission());
    }

    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          iOS: DarwinInitializationSettings(),
          android: AndroidInitializationSettings('logo'),
        ),
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  @pragma('vm:entry-point')

  /// Starts the background service and sets up event listeners for foreground, background, and stop actions.
  /// Periodically logs the current UTC time and device model, and sends updates to the service.
  /// Supports both Android and iOS platforms.
  static Future<void> onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    /// OPTIONAL when use custom notification
    if (kDebugMode) {
      print('start');
    }
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
        if (kDebugMode) {
          print('set as foreground');
        }
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
        if (kDebugMode) {
          print('set as background');
        }
      });
    }
    service.on('stopService').listen((event) {
      service.stopSelf();
      if (kDebugMode) {
        print('stop Service');
      }
    });

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      /// you can see this log in logcat
      if (kDebugMode) {
        print('FLUTTER BACKGROUND SERVICE: ${DateTime.now().toUtc()}');
      }

      // test using external plugin
      final deviceInfo = DeviceInfoPlugin();
      String? device;
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        device = androidInfo.model;
      }

      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        device = iosInfo.model;
      }

      service.invoke(
        'update',
        {
          'current_date': DateTime.now().toUtc().toIso8601String(),
          'device': device,
        },
      );
    });
  }

  @pragma('vm:entry-point')

  /// Handles iOS background service initialization.
  /// Ensures Flutter and Dart plugins are initialized before running background tasks.
  /// Returns `true` when initialization is complete.
  Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }
}
