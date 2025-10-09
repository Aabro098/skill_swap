import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:tcard/tcard.dart';

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
              const MenuWidget(),
              const SizedBox(height: AppSizes.sm),
              AutoSizeText(
                context.tr('discover'),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: AppSizes.md),
              Expanded(
                child: Center(
                  child: TCard(
                    cards: List.generate(
                      5,
                      (index) => MatchCard(
                        name: "Arbin Shreshta",
                        about:
                            "I am someone who is constantly inspired by creativity, innovation, and the endless opportunities to learn and grow. Curiosity drives me forward, whether it is exploring new technologies, reading about ideas that challenge perspectives, or working on projects that allow me to express both logic and imagination.",
                        imageUrl:
                            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=687&q=80",
                        skills: skills,
                        colors: colors,
                        random: random,
                      ),
                    ),
                    size: Size(
                      MediaQuery.of(context).size.width,
                      context.screenHeight * 0.75,
                    ),
                    onForward: (index, info) {
                      debugPrint("Swiped to card $index");
                    },
                    onEnd: () {
                      debugPrint("Reached end of cards");
                    },
                  ),
                ),
              ),
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
      height: context.screenHeight * 0.8,
      margin: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.md),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.md),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            // User Info
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(232),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.md),
                    topRight: Radius.circular(AppSizes.md),
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
                        fontSize: 22,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: AppSizes.xs),
                    AutoSizeText(
                      about,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: Colors.black87,
                      ),
                      maxLines: 3,
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
        child: Icon(icon, color: color, size: 42),
      ),
    );
  }
}
