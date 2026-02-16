import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/providers/auth_provider.dart';
import 'package:skill_swap/screens/Basic/enter_description.dart';
import 'package:skill_swap/screens/Basic/skill_select.dart';
import 'package:skill_swap/services/dio_client.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';
import 'package:skill_swap/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EditProfile extends StatefulWidget {
  final String description;
  final List<String> skills;
  final List<String> wantToLearnSkills;

  const EditProfile({
    required this.description,
    required this.skills,
    required this.wantToLearnSkills,
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = LiquidController();
  final TextEditingController descriptionController = TextEditingController();
  int currentPageIndex = 0;

  List<String> skills = [];
  List<String> wantToLearnSkills = [];

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.description;
    skills = List.from(widget.skills);
    wantToLearnSkills = List.from(widget.wantToLearnSkills);
  }

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
              "Help us get to know your expertise better, please take a moment to add the skills you have.",
          learn: false,
        ),
        SkillsInput(
          key: const ValueKey('wantSkills'),
          skills: wantToLearnSkills,
          onSkillsChanged: (updatedSkills) {
            if (mounted) {
              setState(() {
                wantToLearnSkills = List.from(updatedSkills);
              });
            }
          },
          title: "Enter Skills You Want to Learn!",
          description:
              "Help us get to know your expertise better, please take a moment to add the skills you want to learn.",
          learn: true,
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

  Future<void> editProfile() async {
    try {
      await context.read<AuthProvider>().editProfile(
            description: descriptionController.text.trim(),
            skills: skills,
            wantToLearnSkills: wantToLearnSkills,
          );
      navigatorKey.currentState?.pop();
      return;
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);
      showErrorSnackbar(errorMessage);
      return;
    } catch (e) {
      showErrorSnackbar("An unexpected error occurred while editing profile.");
      return;
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          ? () async {
                              await editProfile();
                            }
                          : _navigateToNextPage,
                      child: Consumer<AuthProvider>(
                        builder: (context, provider, _) {
                          return provider.isLoading
                              ? const Center(
                                  child: SizedBox(
                                    height: AppSizes.lg,
                                    width: AppSizes.lg,
                                    child: CircularProgressIndicator(
                                      color: Colors.green,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : Icon(
                                  currentPageIndex == pages.length - 1
                                      ? Icons.check
                                      : Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 20,
                                );
                        },
                      )),
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
