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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.lg),
        gradient: const LinearGradient(
          colors: [
            Colors.black87,
            Colors.black,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(
        AppSizes.md,
      ),
      child: GNav(
        gap: 8,
        backgroundColor: Colors.transparent,
        color: Colors.grey.shade300, // icon color when unselected
        activeColor: context.colorScheme.primary, // selected icon & text color
        tabBackgroundColor: Colors.purple.shade50, // highlight for selected tab
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md, vertical: AppSizes.sm),
        duration: const Duration(milliseconds: 300),
        selectedIndex: selectedIndex,
        onTabChange: onItemTapped,
        tabs: const [
          GButton(
            icon: Iconsax.message_favorite4,
            text: "Message",
          ),
          GButton(
            icon: Iconsax.search_favorite,
            text: "Match",
          ),
          GButton(
            icon: Iconsax.user_add,
            text: "Contacts",
          ),
        ],
      ),
    );
  }
}
