// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/localization/app_localization.dart';
import 'package:skill_swap/routes/app_routes.dart';
import 'package:skill_swap/screens/Welcome/welcome_screen.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';
import 'package:skill_swap/utils/helpers/localization_manager.dart';
import 'package:skill_swap/notifiers/localization_notifier.dart';
import 'package:skill_swap/notifiers/theme_notifier.dart';
import 'package:skill_swap/utils/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Load saved theme
      await ref.read(themeProvider.notifier).loadTheme();
      // Load saved locale
      await ref.read(localizationProvider.notifier).loadSavedLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localizationProvider);

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
