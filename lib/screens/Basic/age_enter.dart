import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class AgeSelector extends StatefulWidget {
  const AgeSelector({
    super.key,
    required this.selectedAge,
    this.onAgeChanged,
  });
  final int selectedAge;
  final Function(int)? onAgeChanged;

  @override
  State<AgeSelector> createState() => _AgeSelectorState();
}

class _AgeSelectorState extends State<AgeSelector> {
  int age = 18;

  @override
  void initState() {
    super.initState();
    age = widget.selectedAge;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade50,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.padding,
          horizontal: 36.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 92),
            AutoSizeText(
              "Enter Age",
              style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w600, color: Colors.grey.shade800),
            ),
            const SizedBox(height: AppSizes.md),
            AutoSizeText(
              "Hi there! To personalize your experience, please take a moment to enter your age.",
              style: context.textTheme.titleSmall
                  ?.copyWith(color: Colors.grey.shade700),
            ),
            const SizedBox(height: AppSizes.lg),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Age display
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      "$age",
                      style: context.textTheme.headlineLarge?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    AutoSizeText(
                      "years",
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(width: AppSizes.lg),

                SizedBox(
                  height: 300,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Slider(
                      value: age.toDouble(),
                      min: 8,
                      max: 80,
                      divisions: 72,
                      label: "$age",
                      activeColor: context.colorScheme.primary,
                      inactiveColor: Colors.grey.shade300,
                      onChanged: (double value) {
                        if (mounted) {
                          setState(() {
                            age = value.toInt();
                          });
                          widget.onAgeChanged?.call(age);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
