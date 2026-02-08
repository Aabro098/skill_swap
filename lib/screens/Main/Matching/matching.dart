// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/common/widgets/menu_widget.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/user_model.dart';
import 'package:skill_swap/providers/recommended_provider.dart';
import 'package:skill_swap/services/dio_client.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/helper_functions.dart';

class FindMatch extends StatefulWidget {
  const FindMatch({super.key});

  @override
  State<FindMatch> createState() => _FindMatchState();
}

class _FindMatchState extends State<FindMatch> {
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
  void initState() {
    super.initState();
    _loadRecommendedUsers();
  }

  Future<void> _loadRecommendedUsers() async {
    Future.microtask(() async {
      await context.read<RecommendedProvider>().fetchRecommendedUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight,
      width: context.screenWidth,
      decoration: BoxDecoration(
        gradient: context.gradient,
      ),
      child: SafeArea(
        child:
            Consumer<RecommendedProvider>(builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: SingleChildScrollView(
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.recommendedUsers.length,
                    itemBuilder: (context, index) {
                      final user = provider.recommendedUsers[index];

                      if (provider.recommendedUsers.isEmpty) {
                        return SizedBox(
                          height: context.screenHeight,
                          child: Center(
                            child: AutoSizeText(
                              context.tr('No Recommended Users'),
                              style: context.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                      return GestureDetector(
                        onTap: () {},
                        child: MatchCard(
                          user: user,
                          colors: colors,
                          random: random,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class MatchCard extends StatefulWidget {
  final UserModel user;
  final List<Color> colors;
  final Random random;

  const MatchCard({
    super.key,
    required this.user,
    required this.colors,
    required this.random,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  Future<void> _sendrequest() async {
    try {
      await context.read<RecommendedProvider>().sendRequest(id: widget.user.id);
      showSuccessSnackbar("Request Sent Successfully");
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);
      showErrorSnackbar(errorMessage);
    } catch (e) {
      showErrorSnackbar('Something went wrong. Try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * 0.9,
      margin: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.md),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.md),
        ),
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 92,
                  width: 92,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    widget.user.profileUrl,
                    fit: BoxFit.cover,
                    height: 92,
                    width: 92,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        AppImages.fallback,
                        fit: BoxFit.cover,
                        height: 92,
                        width: 92,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : Container(
                                height: 92,
                                width: 92,
                                color: Colors.grey.shade400,
                              ),
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                AutoSizeText(
                  widget.user.name,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                ),
              ],
            ),

            // User Info
            const SizedBox(height: AppSizes.xs),
            AutoSizeText(
              widget.user.description,
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
                ...widget.user.skills.take(5).map(
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
                          color: widget.colors[
                              widget.random.nextInt(widget.colors.length)],
                          width: 2,
                        ),
                      ),
                    ),
                if (widget.user.skills.length > 8)
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionButton(
                  icon: Iconsax.tick_circle,
                  color: Colors.green,
                  onTap: () async {
                    await _sendrequest();
                  },
                ),
              ],
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


// loading: () => SizedBox(
//                           height: context.screenHeight,
//                           child: const Center(
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           ),
//                         ),
//                     error: (error, stackTrace) => SizedBox(
//                           height: context.screenHeight,
//                           child: Center(
//                             child: Text(
//                               context.tr('No Recommended Users Found'),
//                               style: context.textTheme.titleMedium?.copyWith(
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),