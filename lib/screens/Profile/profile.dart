import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/providers/auth_provider.dart';
import 'package:skill_swap/screens/Settings/app_settings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<Color> colors = [
    Colors.red,
    Colors.indigo,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.amber,
  ];

  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const MenuWidget()),
      body: Consumer<AuthProvider>(builder: (context, provider, child) {
        return SafeArea(
          child: Skeletonizer(
            enabled: provider.isLoading,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: SettingsHeader(),
                    ),
                    Center(
                      child: SizedBox(
                        width: 196,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.xl),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(context.tr('edit_profile')),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.sm),
                    AutoSizeText(
                      context.tr('about_me'),
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSizes.xs),
                    AutoSizeText(
                      provider.user?.description ?? '',
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: AppSizes.sm),
                    AutoSizeText(
                      context.tr('skills'),
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSizes.sm),
                    Wrap(
                      spacing: AppSizes.xs,
                      runSpacing: AppSizes.xs,
                      children: (provider.user?.skills != null)
                          ? provider.user!.skills
                              .map(
                                (skill) => Chip(
                                  color: WidgetStatePropertyAll(
                                      Colors.grey.shade50),
                                  padding: const EdgeInsets.all(AppSizes.xs),
                                  visualDensity: VisualDensity.comfortable,
                                  label: Text(
                                    skill,
                                    style: context.textTheme.titleSmall
                                        ?.copyWith(color: Colors.black),
                                  ),
                                  side: BorderSide(
                                      color:
                                          colors[random.nextInt(colors.length)],
                                      width: 2),
                                ),
                              )
                              .toList()
                          : [const SizedBox.shrink()],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
