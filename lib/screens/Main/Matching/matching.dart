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
    return Container(
      decoration: BoxDecoration(
        gradient: context.gradient,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const MenuWidget(),
                  const SizedBox(width: AppSizes.md),
                  AutoSizeText(
                    context.tr('discover'),
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.sm),
              Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return MatchCard(
                        name: "Arbin Shreshta",
                        about:
                            "I am someone who is constantly inspired by creativity, innovation, and the endless opportunities to learn and grow. Curiosity drives me forward, whether it is exploring new technologies, reading about ideas that challenge perspectives, or working on projects that allow me to express both logic and imagination.",
                        imageUrl:
                            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=687&q=80",
                        skills: skills,
                        colors: colors,
                        random: random,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final String name;
  final String about;
  final String imageUrl;
  final List<String> skills;
  final List<Color> colors;
  final Random random;

  const MatchCard({
    super.key,
    required this.name,
    required this.about,
    required this.imageUrl,
    required this.skills,
    required this.colors,
    required this.random,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * 0.9,
      margin: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.md),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.md),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizes.md),
                topRight: Radius.circular(AppSizes.md),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 312,
                width: double.infinity,
              ),
            ),

            // User Info
            Container(
              padding: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(232),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppSizes.md),
                  bottomRight: Radius.circular(AppSizes.md),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    name,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  AutoSizeText(
                    about,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs),

                  // Skill Chips
                  Wrap(
                    spacing: AppSizes.xs,
                    runSpacing: 0,
                    children: [
                      ...skills.take(5).map(
                            (skill) => Chip(
                              padding: const EdgeInsets.all(AppSizes.xs),
                              visualDensity: VisualDensity.compact,
                              backgroundColor: Colors.white,
                              label: Text(
                                skill,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              side: BorderSide(
                                color: colors[random.nextInt(colors.length)],
                                width: 2,
                              ),
                            ),
                          ),
                      if (skills.length > 5)
                        Chip(
                          padding: const EdgeInsets.all(AppSizes.xs),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: Colors.white,
                          label: Text("...",
                              style: context.textTheme.titleLarge
                                  ?.copyWith(color: Colors.black)),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.sm),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _actionButton(
                        icon: Iconsax.close_circle,
                        color: Colors.red.shade700,
                        onTap: () => debugPrint("Disliked"),
                      ),
                      const SizedBox(width: AppSizes.md),
                      _actionButton(
                        icon: Iconsax.tick_circle,
                        color: Colors.green,
                        onTap: () => debugPrint("Liked"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(icon, color: color, size: 36),
      ),
    );
  }
}
