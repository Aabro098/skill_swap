import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/theme/custom/text_theme.dart';

class DescriptionScreen extends StatefulWidget {
  final TextEditingController? controller;
  const DescriptionScreen({
    required this.controller,
    super.key,
  });

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
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
              "Enter Description",
              style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w600, color: Colors.grey.shade800),
            ),
            const SizedBox(height: AppSizes.md),
            AutoSizeText(
              "Hi there! To personalize your experience, please take a moment to enter a short description.",
              style: context.textTheme.titleSmall
                  ?.copyWith(color: Colors.grey.shade700),
            ),
            const SizedBox(height: AppSizes.lg),
            TextFormField(
              controller: widget.controller,
              textInputAction: TextInputAction.done,
              maxLines: 6,
              style: AppTypography.lightTextTheme.titleSmall
                  ?.copyWith(color: Colors.black),
              decoration: const InputDecoration(
                hintText: "Enter your description here...",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
