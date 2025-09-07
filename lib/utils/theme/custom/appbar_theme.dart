import 'package:flutter/material.dart';
import 'package:skill_swap/utils/constants/colors.dart';
import 'package:skill_swap/utils/theme/custom/text_theme.dart';

class AppAppBarTheme {
  static AppBarTheme lightTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.lightSecondary,
    titleTextStyle: AppTypography.lightTextTheme.titleMedium
        ?.copyWith(color: AppColors.darkSecondary),
    centerTitle: false,
    toolbarHeight: 62,
    elevation: 0,
  );

  static AppBarTheme darkTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.darkSecondary,
    titleTextStyle: AppTypography.lightTextTheme.titleMedium
        ?.copyWith(color: AppColors.darkSecondary),
    centerTitle: false,
    toolbarHeight: 62,
    elevation: 0,
  );
}
