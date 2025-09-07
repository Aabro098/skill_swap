// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class CountryButton extends StatelessWidget {
  const CountryButton({
    super.key,
    required this.flag,
    required this.label,
    required this.color,
    this.selected = false,
    required this.onTap,
  });
  final String flag;
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),
        width: 136,
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.3) : Colors.transparent,
          border: Border.all(
            color: color,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppSizes.md),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              flag,
              height: 24,
              width: 24,
            ),
            const SizedBox(
              width: AppSizes.sm,
            ),
            AutoSizeText(
              label,
              style: context.textTheme.titleSmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
