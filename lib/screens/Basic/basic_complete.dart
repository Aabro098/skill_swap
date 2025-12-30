import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:skill_swap/common/widgets/drawer_page.dart';
import 'package:skill_swap/model/auth_state.dart';
import 'package:skill_swap/notifiers/auth_notifier.dart';
import 'package:skill_swap/screens/Basic/enter_description.dart';
import 'package:skill_swap/screens/Basic/skill_select.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';
import 'package:skill_swap/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicComplete extends ConsumerStatefulWidget {
  final String id;
  const BasicComplete({required this.id, super.key});

  static const String routeName = '/basic_complete';

  @override
  ConsumerState<BasicComplete> createState() => _BasicCompleteState();
}

class _BasicCompleteState extends ConsumerState<BasicComplete> {
  final controller = LiquidController();
  final TextEditingController descriptionController = TextEditingController();
  int currentPageIndex = 0;

  List<String> skills = [];

  List<Widget> get pages => [
        DescriptionScreen(
          controller: descriptionController,
        ),
        SkillsInput(
          key: const ValueKey('haveSkills'),
          skills: skills,
          onSkillsChanged: (updatedSkills) {
            if (mounted) {
              setState(() {
                skills = List.from(updatedSkills);
              });
            }
          },
          title: "Enter Skills You Have!",
          description:
              "Hi there! To help us get to know your expertise better, please take a moment to add the skills you have.",
          learn: false,
        ),
      ];

  void _handlePageChange(int index) {
    if (mounted) {
      setState(() {
        currentPageIndex = index;
      });
    }
  }

  void _navigateToNextPage() {
    int nextPage = currentPageIndex + 1;
    controller.jumpToPage(page: nextPage);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) async {
      final error = next.error;

      if (error != null && error.isNotEmpty) {
        showErrorSnackbar(context: context, error);
      }

      if (next.success == true) {
        await navigatorKey.currentState!.pushNamedAndRemoveUntil(
          DrawerPage.routeName,
          (_) => false,
        );
      }
    });
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: controller,
            fullTransitionValue: 300,
            enableLoop: false,
            waveType: WaveType.liquidReveal,
            positionSlideIcon: 0.5,
            slideIconWidget: currentPageIndex == 1
                ? null
                : const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
            enableSideReveal: true,
            onPageChangeCallback: _handlePageChange,
          ),

          // Bottom navigation area
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Navigation button
                SizedBox(
                  width: 40,
                  height: 40,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.black87,
                      side: const BorderSide(color: Colors.black87, width: 2),
                    ),
                    onPressed: currentPageIndex == pages.length - 1
                        ? () {
                            ref
                                .read(authNotifierProvider.notifier)
                                .completeProfile(
                                  id: widget.id,
                                  description:
                                      descriptionController.text.trim(),
                                  skills: skills,
                                );
                          }
                        : _navigateToNextPage,
                    child: authState.isLoading
                        ? const Center(
                            child: SizedBox(
                            height: AppSizes.lg,
                            width: AppSizes.lg,
                            child: CircularProgressIndicator(
                              color: Colors.green,
                              strokeWidth: 2,
                            ),
                          ))
                        : Icon(
                            currentPageIndex == pages.length - 1
                                ? Icons.check
                                : Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                  ),
                ),
                const SizedBox(height: AppSizes.lg),
                // Page indicator
                AnimatedSmoothIndicator(
                  activeIndex: currentPageIndex,
                  count: pages.length,
                  effect: const WormEffect(
                    activeDotColor: Colors.black87,
                    dotHeight: 2.0,
                    dotWidth: 8.0,
                    spacing: 8.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
