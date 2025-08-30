import 'package:flutter/material.dart';
import 'package:skill_swap/utils/constants/colors.dart';
import 'package:skill_swap/utils/theme/color_scheme.dart';
import 'package:skill_swap/utils/theme/custom/elevated_button_theme.dart';
import 'package:skill_swap/utils/theme/custom/input_decoration_theme.dart';
import 'package:skill_swap/utils/theme/custom/outlined_button_theme.dart';
import 'package:skill_swap/utils/theme/custom/page_transitions_theme.dart';
import 'package:skill_swap/utils/theme/custom/snacker_bar_theme.dart';
import 'package:skill_swap/utils/theme/custom/text_theme.dart';

class AppTheme {
  AppTheme._();

  // *ThemeData created for both Light Theme and Dark Theme

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    colorScheme: AppColorSchemes.lightColorScheme,
    primaryColor: AppColors.lightPrimary,
    textTheme: AppTypography.lightTextTheme,
    pageTransitionsTheme: AppPageTransitionsTheme.pageTransitionsTheme,
    inputDecorationTheme: AppInputDecoration.lightTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightTheme,
    snackBarTheme: AppSnackbarTheme.theme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    colorScheme: AppColorSchemes.darkColorScheme,
    primaryColor: AppColors.darkPrimary,
    textTheme: AppTypography.darkTextTheme,
    pageTransitionsTheme: AppPageTransitionsTheme.pageTransitionsTheme,
    inputDecorationTheme: AppInputDecoration.darkTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkTheme,
    snackBarTheme: AppSnackbarTheme.theme,
  );
}
