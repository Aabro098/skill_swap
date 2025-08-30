import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_mts/utils/constants/colors.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/localization_manager.dart';
import 'package:flutter_boilerplate_mts/utils/providers/localization_provider.dart';
import 'package:provider/provider.dart';

/// A widget that displays a dropdown menu for selecting the app's language.
///
/// Uses [LocalizationProvider] to get and set the current locale.
class LanguageSelector extends StatefulWidget {
  /// Constructor for Language Selector
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late Locale selectedLocale;

  @override
  void initState() {
    super.initState();
    selectedLocale = context.read<LocalizationProvider>().locale;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Locale>(
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0xff2B9486),
        isDense: true,
        filled: true,
        iconColor: AppColors.background,
        suffixIconColor: AppColors.background,
        constraints: BoxConstraints.tightFor(height: 40),
      ),
      width: 90,
      textStyle: const TextStyle(
        color: AppColors.background,
        fontSize: 12,
      ),
      initialSelection: selectedLocale,
      dropdownMenuEntries:
          LocalizationManager.supportedLocales.map((localeMap) {
        final locale = localeMap['locale'] as Locale;
        return DropdownMenuEntry<Locale>(
          value: locale,
          label: locale.languageCode.toUpperCase(),
        );
      }).toList(),
      onSelected: (Locale? newLocale) {
        if (newLocale != null) {
          setState(() {
            selectedLocale = newLocale;
          });
          context.read<LocalizationProvider>().switchLocale(newLocale);
        }
      },
    );
  }
}
