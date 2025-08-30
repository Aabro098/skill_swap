import 'package:flutter/material.dart';
import 'package:skill_swap/utils/constants/colors.dart';
import 'package:skill_swap/utils/theme/custom/text_theme.dart';

/// Class for Outlined Button Theme with static variables for light and dark themes
class AppOutlinedButtonTheme {
  /// Static variable for Outlined Button (Light)
  static OutlinedButtonThemeData lightTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.lightPrimary,
      textStyle: AppTypography.lightTextTheme.titleSmall,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      minimumSize: const Size(double.infinity, 42),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Less circular
      ),
      side: const BorderSide(
        color: AppColors.lightPrimary,
      ),
    ),
  );

  /// Static variable for Outlined Button (Dark)
  static OutlinedButtonThemeData darkTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: AppTypography.lightTextTheme.titleSmall,
      foregroundColor: AppColors.darkPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      minimumSize: const Size(double.infinity, 42),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Match light theme
      ),
      side: const BorderSide(
        color: AppColors.darkPrimary,
      ),
    ),
  );
}
