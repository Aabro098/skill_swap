import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/common/reusables/flag_button.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/providers/localization_provider.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/helper_functions.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({
    super.key,
    required this.onDone,
  });
  final void Function(BuildContext context) onDone;

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  // Map your selectedLang to a Locale
  final localeMap = {
    "ne": const Locale("ne", "NP"),
    "hi": const Locale("hi", "IN"),
    "en": const Locale("en", "US"),
    "ja": const Locale("ja", "JP"),
    "de": const Locale("de", "DE"),
  };
  String? selectedLang;

  void updateLocale(Locale locale) {
    if (mounted) {
      setState(() {
        selectedLang = locale.languageCode;
        // Update the notifier's state
        context.read<LocalizationProvider>().switchLocale(locale);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: AppSizes.lg,
              ),
              AutoSizeText(
                context.tr('select_language'),
                style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.primary),
              ),
              const SizedBox(
                height: AppSizes.xl,
              ),
              Wrap(
                spacing: AppSizes.md,
                runSpacing: AppSizes.md,
                alignment: WrapAlignment.center,
                children: [
                  CountryButton(
                    flag: AppImages.nepal,
                    label: "नेपाली",
                    color: Colors.redAccent,
                    selected: selectedLang == "ne",
                    onTap: () => setState(() => selectedLang = "ne"),
                  ),
                  CountryButton(
                    flag: AppImages.india,
                    label: "हिन्दी",
                    color: Colors.orange,
                    selected: selectedLang == "hi",
                    onTap: () => setState(() => selectedLang = "hi"),
                  ),
                  CountryButton(
                    flag: AppImages.english,
                    label: "English",
                    color: Colors.blueGrey,
                    selected: selectedLang == "en",
                    onTap: () => setState(() => selectedLang = "en"),
                  ),
                  CountryButton(
                    flag: AppImages.japan,
                    label: "日本語",
                    color: Colors.red,
                    selected: selectedLang == "ja",
                    onTap: () => setState(() => selectedLang = "ja"),
                  ),
                  CountryButton(
                    flag: AppImages.germany,
                    label: "Deutsch",
                    color: Colors.deepOrange,
                    selected: selectedLang == "de",
                    onTap: () => setState(() => selectedLang = "de"),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (selectedLang == null) {
                    showErrorSnackbar(
                      context.tr("select_language"),
                    );
                    return;
                  }
                  final locale = localeMap[selectedLang]!;

                  updateLocale(locale);

                  widget.onDone(context);
                },
                child: Text(
                  context.tr('done'),
                ),
              ),
              const SizedBox(
                height: AppSizes.lg,
              )
            ],
          ),
        ),
      ),
    );
  }
}
