import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class FindMatch extends StatefulWidget {
  const FindMatch({super.key});

  @override
  State<FindMatch> createState() => _FindMatchState();
}

class _FindMatchState extends State<FindMatch> {
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
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: context.gradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MenuWidget(),
              const SizedBox(height: AppSizes.sm),
              AutoSizeText(
                "Discover",
                style: context.textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSizes.md),
              // Expanded to fill available space
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return MatchCard(
                      skills: skills,
                      colors: colors,
                      random: random,
                    );
                  },
                ),
              ),
              Center(
                child: Icon(
                  Iconsax.arrow_circle_right,
                  color: context.colorScheme.primary,
                  size: 32,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.skills,
    required this.colors,
    required this.random,
  });

  final List<String> skills;
  final List<Color> colors;
  final Random random;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              height: context.screenHeight * 0.5,
              width: context.screenWidth * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.md),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.md),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=687&q=80",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: AppSizes.sm,
                      left: AppSizes.sm,
                      right: AppSizes.sm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.md,
                          vertical: AppSizes.sm,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(232),
                          borderRadius: BorderRadius.circular(AppSizes.md),
                        ),
                        child: Column(
                          children: [
                            AutoSizeText(
                              "Arbin Shreshta",
                              style: context.textTheme.titleLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSizes.xs),
                            AutoSizeText(
                              "I am someone who is constantly inspired by creativity, innovation, and the endless opportunities to learn and grow. Curiosity drives me forward, whether it is exploring new technologies, reading about ideas that challenge perspectives, or working on projects that allow me to express both logic and imagination. I believe in building things that make life easier, smarter, and more meaningful for people.",
                              style: context.textTheme.labelMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.md),
          Wrap(
            spacing: AppSizes.sm,
            runSpacing: AppSizes.xs,
            children: [
              // Display up to 5 skills
              ...skills.take(5).map(
                    (skill) => Chip(
                      backgroundColor: Colors.grey.shade50,
                      label: Text(
                        skill,
                        style: context.textTheme.titleSmall
                            ?.copyWith(color: Colors.black),
                      ),
                      side: BorderSide(
                        color: colors[random.nextInt(colors.length)],
                        width: 2,
                      ),
                    ),
                  ),
              // If more than 5 skills, add "..." chip
              if (skills.length > 5)
                Text(
                  "...",
                  style: context.textTheme.titleLarge?.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(Iconsax.tick_circle,
                      color: Colors.green, size: 64),
                  onTap: () {},
                ),
                const SizedBox(width: AppSizes.sm),
                GestureDetector(
                  child: Icon(Iconsax.close_circle,
                      color: Colors.red.shade900, size: 64),
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
