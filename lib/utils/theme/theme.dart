import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_mts/utils/theme/custom/dropdown_theme.dart';
import 'package:flutter_boilerplate_mts/utils/theme/custom/elevated_button_theme.dart';
import 'package:flutter_boilerplate_mts/utils/theme/custom/input_decoration_theme.dart';
import 'package:flutter_boilerplate_mts/utils/theme/custom/page_transitions_theme.dart';
import 'package:flutter_boilerplate_mts/utils/theme/custom/snacker_bar_theme.dart';
import 'package:flutter_boilerplate_mts/utils/theme/custom/text_theme.dart';

class AppTheme {
  AppTheme._();

  // *ThemeData created for both Light Theme and Dark Theme

  /*
  TODO: Add more Theme Classes
  TODO: Add more attributes to theme data
  */

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: AppTypography.lightTextTheme,
    pageTransitionsTheme: AppPageTransitionsTheme.pageTransitionsTheme,
    inputDecorationTheme: AppInputDecoration.lightTheme,
    elevatedButtonTheme: AppButtonTheme.lightTheme,
    dropdownMenuTheme: AppDropdownMenuTheme.dropdownMenuTheme,
    snackBarTheme: AppSnackerBarTheme.snackerBarTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: AppTypography.darkTextTheme,
    pageTransitionsTheme: AppPageTransitionsTheme.pageTransitionsTheme,
    inputDecorationTheme: AppInputDecoration.darkTheme,
    elevatedButtonTheme: AppButtonTheme.darkTheme,
    dropdownMenuTheme: AppDropdownMenuTheme.dropdownMenuTheme,
    snackBarTheme: AppSnackerBarTheme.snackerBarTheme,
  );
}
