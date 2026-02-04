import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: 12,
        ),
        child: GNav(
          gap: 8,
          backgroundColor: Colors.transparent,
          color: context.colorScheme.primary, // icon color when unselected
          activeColor: Colors.white, // selected icon & text color
          tabBackgroundColor:
              context.colorScheme.primary, // highlight for selected tab
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md, vertical: AppSizes.sm),
          duration: const Duration(milliseconds: 300),
          selectedIndex: selectedIndex,
          onTabChange: onItemTapped,
          tabs: [
            GButton(
              icon: Iconsax.message_favorite4,
              text: context.tr('messages'),
            ),
            GButton(
              icon: Iconsax.search_favorite,
              text: context.tr('discover'),
            ),
            GButton(
              icon: Iconsax.user_add,
              text: context.tr('contacts'),
            ),
          ],
        ),
      ),
    );
  }
}
