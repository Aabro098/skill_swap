import 'package:flutter/material.dart';
import 'package:skill_swap/utils/constants/enums.dart';

class SettingsItemModel {
  final String title;
  final IconData icon;
  final SettingsTileType type;

  // For switch tile
  final bool? value;
  final ValueChanged<bool>? onChanged;

  // For navigation tile
  final VoidCallback? onTap;

  // For custom trailing widget
  final Widget? trailing;

  final Color? color;

  SettingsItemModel({
    required this.title,
    required this.icon,
    required this.type,
    this.value,
    this.onChanged,
    this.onTap,
    this.trailing,
    this.color,
  });
}
