import 'package:flutter/material.dart';
import 'package:skill_swap/utils/constants/colors.dart';

class AppColorSchemes {
  AppColorSchemes._();

  /// Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.lightPrimary,
    onPrimary: Colors.white,
    secondary: AppColors.lightSecondary,
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: AppColors.lightTextPrimary,
    error: AppColors.lightError,
    onError: Colors.white,
  );

  /// Dark Color Scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: Colors.black,
    secondary: AppColors.darkSecondary,
    onSecondary: Colors.white,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,
    error: AppColors.darkError,
    onError: Colors.black,
  );
}
