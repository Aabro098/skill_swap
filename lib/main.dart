import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/app.dart';
import 'package:skill_swap/utils/helpers/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Notification Service initialization
  await NotificationService().initiNotification();

  // Enable full-screen mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

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
