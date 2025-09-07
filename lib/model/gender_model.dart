import 'package:flutter/material.dart';

class GenderOptionModel {
  final String gender;
  final Color primaryColor;
  final Color secondaryColor;
  final Color shadeColor;
  final IconData icon;

  GenderOptionModel({
    required this.gender,
    required this.primaryColor,
    required this.secondaryColor,
    required this.shadeColor,
    required this.icon,
  });
}
