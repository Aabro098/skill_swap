// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:skill_swap/localization/app_localization.dart';
import 'package:skill_swap/screens/Welcome/OnBoarding/language_select.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';
import 'package:skill_swap/utils/helpers/localization_manager.dart';
import 'package:skill_swap/utils/providers/localization_provider.dart';
import 'package:skill_swap/utils/providers/theme.provider.dart';
import 'package:skill_swap/utils/theme/theme.dart';
import 'package:provider/provider.dart';
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
      final contextToUse = scaffoldMessengerKey.currentContext ?? context;
      await Provider.of<ThemeProvider>(contextToUse, listen: false).loadTheme();
      await Provider.of<LocalizationProvider>(
        contextToUse,
        listen: false,
      ).loadSavedLocale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocalizationProvider, ThemeProvider>(
      builder: (context, localizationProvider, themeProvider, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          locale: localizationProvider.locale,
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
          themeMode: themeProvider.themeMode,
          title: 'Skill Swap',
          home: const LanguageSelector(),
        );
      },
    );
  }
}
