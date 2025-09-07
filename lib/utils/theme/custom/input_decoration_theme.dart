import 'package:flutter/material.dart';
import 'package:skill_swap/utils/constants/colors.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/theme/custom/text_theme.dart';

/// Class for Input Decoration Theme with static variable `lightTheme`
class AppInputDecoration {
  /// Static variable for Input Decoration (Light)
  static InputDecorationTheme lightTheme = InputDecorationTheme(
    hintStyle: AppTypography.lightTextTheme.titleSmall,
    contentPadding: const EdgeInsets.symmetric(
      vertical: AppSizes.xs,
      horizontal: AppSizes.md,
    ),
    prefixIconColor: AppColors.lightPrimary,
    suffixIconColor: AppColors.lightPrimary,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.lightPrimary,
        width: 1.2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.lightPrimary,
        width: 1.2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.2,
      ),
    ),
  );

  static InputDecorationTheme darkTheme = InputDecorationTheme(
    hintStyle: AppTypography.darkTextTheme.titleSmall,
    contentPadding: const EdgeInsets.symmetric(
      vertical: AppSizes.xs,
      horizontal: AppSizes.md,
    ),
    prefixIconColor: AppColors.darkPrimary,
    suffixIconColor: AppColors.darkPrimary,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 1.2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.darkPrimary,
        width: 1.2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.darkPrimary,
        width: 1.2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 1.2,
      ),
    ),
  );
}
