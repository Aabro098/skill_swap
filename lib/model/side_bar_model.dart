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
    title: "home",
  );
  static const chatbot = MenuItem(
    icon: Iconsax.message_24,
    title: "skill_bot",
  );
  static const profile = MenuItem(
    icon: Iconsax.user,
    title: "profile",
  );

  static const settings = MenuItem(
    icon: Iconsax.setting_24,
    title: "settings",
  );

  static const all = <MenuItem>[
    home,
    chatbot,
    profile,
    settings,
  ];
}
