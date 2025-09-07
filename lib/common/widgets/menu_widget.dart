import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/extensions/context_extensions.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () => ZoomDrawer.of(context)!.toggle(),
        icon: Icon(
          Iconsax.menu,
          color: context.colorScheme.primary,
        ),
      );
}
