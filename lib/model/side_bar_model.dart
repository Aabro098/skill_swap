import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MenuItem {
  final IconData icon;
  final String title;

  const MenuItem({
    required this.icon,
    required this.title,
  });

  static const home = MenuItem(
    icon: Iconsax.home_14,
    title: "Home",
  );
  static const chatbot = MenuItem(
    icon: Iconsax.message_24,
    title: "Skill Bot",
  );
  static const profile = MenuItem(
    icon: Iconsax.user,
    title: "Profile",
  );

  static const settings = MenuItem(
    icon: Iconsax.setting_24,
    title: "Settings",
  );

  static const all = <MenuItem>[
    home,
    chatbot,
    profile,
    settings,
  ];
}
