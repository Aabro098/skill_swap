import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/onboarding_model.dart';
import 'package:skill_swap/screens/Auth/login_screen.dart';
import 'package:skill_swap/screens/Welcome/OnBoarding/onboarding_component.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();
  int currentPageIndex = 0;

  final pages = [
    OnboardingComponent(
      model: OnboardingModel(
        image: AppImages.onboarding1,
        title: "Learning & Growth",
        description:
            "“Learn new skills at your own pace, share what you know with others, and watch your potential grow every day. Together, we make learning a journey, not just a destination.”",
        bgColor: Colors.deepOrange.shade100,
      ),
    ),
    OnboardingComponent(
      model: OnboardingModel(
        image: AppImages.onboarding2,
        title: "Community & Collaboration",
        description:
            "“Share your expertise, discover new skills, and build meaningful connections. Our community thrives when everyone contributes and learns together.”",
        bgColor: Colors.green.shade100,
      ),
    ),
    OnboardingComponent(
      model: OnboardingModel(
        image: AppImages.main,
        title: "Fun & Creative",
        description:
            "“Swap your skills, spark new ideas, and create opportunities you never imagined. Learning has never been this social, inspiring, or fun.”",
        bgColor: Colors.indigo.shade100,
      ),
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
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  void _skipToEnd() {
    controller.jumpToPage(page: pages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main LiquidSwipe content
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

            // Skip button - positioned safely
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              right: 20,
              child: TextButton(
                onPressed: _skipToEnd,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: AutoSizeText(
                  "Skip",
                  style: context.textTheme.titleSmall?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
      ),
    );
  }
}
