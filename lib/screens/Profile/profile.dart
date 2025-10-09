import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/screens/Settings/app_settings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class Profile extends StatefulWidget {
  final bool isView;
  const Profile({super.key, this.isView = false});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> skills = [
    "Flutter",
    "Dart",
    "Python",
    "Project Management",
    "Data Analysis",
    "Machine Learning",
    "Public Speaking",
    "Creative Writing",
  ];

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
      appBar: AppBar(
        leading: !widget.isView
            ? const MenuWidget()
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: SettingsHeader(),
              ),
              !widget.isView
                  ? const SizedBox(height: AppSizes.sm)
                  : const SizedBox.shrink(),
              !widget.isView
                  ? Center(
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
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: AppSizes.sm),
              AutoSizeText(
                context.tr('about_me'),
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: AppSizes.xs),
              AutoSizeText(
                "I am someone who is constantly inspired by creativity, innovation, and the endless opportunities to learn and grow. Curiosity drives me forward, whether it is exploring new technologies, reading about ideas that challenge perspectives, or working on projects that allow me to express both logic and imagination. I believe in building things that make life easier, smarter, and more meaningful for people.",
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
                children: skills
                    .map((skill) => Chip(
                          color: WidgetStatePropertyAll(Colors.grey.shade50),
                          padding: const EdgeInsets.all(AppSizes.xs),
                          visualDensity: VisualDensity.comfortable,
                          label: Text(
                            skill,
                            style: context.textTheme.titleSmall
                                ?.copyWith(color: Colors.black),
                          ),
                          side: BorderSide(
                              color: colors[random.nextInt(colors.length)],
                              width: 2),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
