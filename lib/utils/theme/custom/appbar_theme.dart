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
    scrolledUnderElevation: 0,
    // systemOverlayStyle: const SystemUiOverlayStyle(
    //   statusBarColor: AppColors.lightPrimary,
    //   statusBarIconBrightness: Brightness.light,
    //   statusBarBrightness: Brightness.dark,
    // ),
  );

  static AppBarTheme darkTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.darkSecondary,
    titleTextStyle: AppTypography.darkTextTheme.titleMedium
        ?.copyWith(color: AppColors.darkSecondary),
    centerTitle: false,
    toolbarHeight: 62,
    elevation: 0,
    scrolledUnderElevation: 0,
    // systemOverlayStyle: const SystemUiOverlayStyle(
    //   statusBarColor: AppColors.darkPrimary,
    //   statusBarIconBrightness: Brightness.light,
    //   statusBarBrightness: Brightness.dark,
    // ),
  );
}
