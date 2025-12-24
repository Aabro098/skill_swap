import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/app.dart';
import 'package:skill_swap/utils/helpers/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Notification Service initialization
  await NotificationService().initiNotification();

  // Restore system UI and set status bar style
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF9C27B0), // Primary purple color
        statusBarIconBrightness:
            Brightness.light, // White icons on dark background
        statusBarBrightness: Brightness.dark, // For iOS
        systemNavigationBarColor: Colors.black),
  );

  // Allow only portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      const ProviderScope(
        child: App(),
      ),
    );
  });
}
