// Self Explainatory
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  //! === Primary Brand Colors ===
  static const Color primary = Color(0xFF007E6E);
  static const Color primaryClicked = Color(0xFF00594E);
  static const Color primaryDisabled = Color(0xFFE5E5E5);

  //! === Secondary Colors ===
  static const Color secondary = Color(0x2B948685); // 53% opacity
  static const Color secondaryClicked = Color(0xCC00594E); // 80% opacity

  //! === Info Button ===
  static const Color info = Color(0xFF1E99DC);

  //! === Background / Surface ===
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0x1A111111); // 10% opacity
  static const Color container = Color(0x52E0E6E6); // 52 for 32% opacity

  //! === Tile / Hover / Selector ===
  static const Color tile = Color(0x14007E6E); // 8% opacity

  //! === Pills ===
  static const Color pillBackground = Color(0x0F007E6E); // 6% opacity
  static const Color pillText = Color(0xFF007E6E);

  //! === Error ===
  static const Color error = Color(0xFFCF0124);

  //! === Text Colors ===
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0x99111111); // 60% opacity
  static const Color textTertiary = Color(0x73111111); // 45% opacity
  static const Color textQuaternary = Color(0xA6111111);
}
