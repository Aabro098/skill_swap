import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:skill_swap/screens/Basic/age_enter.dart';
import 'package:skill_swap/screens/Basic/gender_select.dart';
import 'package:skill_swap/screens/Basic/skill_select.dart';
import 'package:skill_swap/screens/homepage/homepage.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BasicComplete extends StatefulWidget {
  const BasicComplete({super.key});

  @override
  State<BasicComplete> createState() => _BasicCompleteState();
}

class _BasicCompleteState extends State<BasicComplete> {
  final controller = LiquidController();
  int currentPageIndex = 0;

  String? selectedGender;
  int selectedAge = 18;
  List<String> skills = [];

  List<Widget> get pages => [
        SelectGender(
          selectedGender: selectedGender,
          onGenderSelected: (gender) {
            if (mounted) {
              setState(() {
                selectedGender = gender;
              });
            }
          },
        ),
        AgeSelector(
          selectedAge: selectedAge,
          onAgeChanged: (age) {
            if (mounted) {
              setState(() {
                selectedAge = age;
              });
            }
          },
        ),
        SkillsInput(
          skills: skills,
          onSkillsChanged: (updatedSkills) {
            if (mounted) {
              setState(() {
                skills = List.from(updatedSkills);
              });
            }
          },
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
    if (nextPage < pages.length) {
      controller.jumpToPage(page: nextPage);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ),
      );
    }
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
            slideIconWidget: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            enableSideReveal: true,
            onPageChangeCallback: _handlePageChange,
          ),

          // Bottom navigation area
          Positioned(
            bottom: 20,
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
                    onPressed: _navigateToNextPage,
                    child: Icon(
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
