import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;

  const RoundedTextField({
    super.key,
    this.hintText = "Search",
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(36.0),
      borderSide: BorderSide.none,
    );

    return TextField(
      style: context.textTheme.titleSmall
          ?.copyWith(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.textTheme.titleSmall
            ?.copyWith(color: Colors.white, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),
        prefixIcon: const Icon(
          Iconsax.search_favorite,
        ),
        filled: true,
        fillColor: Colors.white.withAlpha(24),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        disabledBorder: border,
      ),
    );
  }
}
