// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/localization/app_localization.dart';
import 'package:skill_swap/providers/localization_provider.dart';
import 'package:skill_swap/routes/app_routes.dart';
import 'package:skill_swap/screens/Welcome/welcome_screen.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';
import 'package:skill_swap/utils/helpers/localization_manager.dart';
import 'package:skill_swap/providers/theme_provider.dart';
import 'package:skill_swap/utils/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Load saved theme
      await context.read<ThemeProvider>().loadTheme();
      // Load saved locale
      await context.read<LocalizationProvider>().loadSavedLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().themeMode;
    final locale = context.watch<LocalizationProvider>().locale;

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      locale: locale,
      scaffoldMessengerKey: scaffoldMessengerKey,
      supportedLocales: LocalizationManager.supportedLocaleList,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        return supportedLocales.firstWhere(
          (supportedLocale) =>
              supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode,
          orElse: () => supportedLocales.first,
        );
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      title: 'Skill Swap',

      /// ROUTING
      onGenerateRoute: (settings) {
        final builder = appRoutes[settings.name];
        if (builder == null) {
          return _errorRoute(settings.name);
        }

        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
      home: const WelcomeScreen(),
    );
  }

  Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Route not found')),
        body: Center(child: Text('No route defined for $name')),
      ),
    );
  }
}
