import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final Color? fillColor;
  final Color? textColor;
  final IconData? prefixIcon;
  final bool enabled;
  final TextEditingController? controller;

  const RoundedTextField({
    super.key,
    this.hintText = "Search",
    this.fillColor,
    this.textColor,
    this.prefixIcon,
    this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(36.0),
      borderSide: BorderSide.none,
    );

    return TextFormField(
      style: context.textTheme.titleSmall
          ?.copyWith(color: textColor ?? Colors.white, fontSize: 14),
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.textTheme.titleSmall
            ?.copyWith(color: textColor ?? Colors.white, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
              )
            : null,
        filled: true,
        fillColor: fillColor ?? Colors.white.withAlpha(24),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        disabledBorder: border,
      ),
    );
  }
}
