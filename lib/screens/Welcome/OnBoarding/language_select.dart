import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skill_swap/common/reusables/flag_button.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/helper_functions.dart';
import 'package:skill_swap/utils/notifiers/localization_notifier.dart';

class LanguageSelector extends ConsumerStatefulWidget {
  const LanguageSelector({
    super.key,
    required this.onDone,
  });
  final void Function(BuildContext context) onDone;

  @override
  ConsumerState<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends ConsumerState<LanguageSelector> {
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
        ref.read(localizationProvider.notifier).switchLocale(locale);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize selectedLang only once
    selectedLang ??= ref.read(localizationProvider).languageCode;
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
                "Select Language",
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
                    showErrorSnackbar("Select a Language", context: context);
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
