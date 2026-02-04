import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/app.dart';
import 'package:skill_swap/providers/auth_provider.dart';
import 'package:skill_swap/providers/friends_provider.dart';
import 'package:skill_swap/providers/localization_provider.dart';
import 'package:skill_swap/providers/recommended_provider.dart';
import 'package:skill_swap/providers/theme_provider.dart';
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
  ]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => LocalizationProvider()),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => FriendProvider()),
            ChangeNotifierProvider(create: (_) => RecommendedProvider()),
          ],
          child: const App(),
        ),
      );
    },
  );
}
