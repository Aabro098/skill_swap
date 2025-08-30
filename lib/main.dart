import 'package:flutter/material.dart';
import 'package:skill_swap/app.dart';
import 'package:skill_swap/utils/helpers/notification_service.dart';
import 'package:skill_swap/utils/providers/localization_provider.dart';
import 'package:skill_swap/utils/providers/theme.provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Notification Service initialization
  NotificationService().initiNotification();

  runApp(
    // *Using MutliProvider for further addition of providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: const App(),
    ),
  );
}
