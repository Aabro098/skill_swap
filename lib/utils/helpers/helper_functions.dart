import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';

void showErrorSnackbar(String message) {
  scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: Colors.red, // overrides theme
      duration: const Duration(seconds: 2),
      content: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.close_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: AutoSizeText(
                message,
                style: scaffoldMessengerKey.currentContext?.textTheme.titleSmall
                    ?.copyWith(color: Colors.white),
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.all(AppSizes.md),
    ),
  );
}

void showSuccessSnackbar(String message) {
  scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: Colors.green, // overrides theme
      duration: const Duration(seconds: 2),
      content: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.tick_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: AutoSizeText(
                message,
                style: scaffoldMessengerKey.currentContext?.textTheme.titleSmall
                    ?.copyWith(color: Colors.white),
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.all(AppSizes.md),
    ),
  );
}

void showInfoSnackbar(String message) {
  scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: Colors.blue, // overrides theme
      duration: const Duration(seconds: 2),
      content: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.info_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: AutoSizeText(
                message,
                style: scaffoldMessengerKey.currentContext?.textTheme.titleSmall
                    ?.copyWith(color: Colors.white),
                maxLines: null,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.all(AppSizes.md),
    ),
  );
}
