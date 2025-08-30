import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/screens/Welcome/OnBoarding/liquid_swipe.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 360,
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Transform.rotate(
                        angle: 0.3,
                        child: Image.asset(
                          AppImages.onboarding1,
                          width: 160,
                          height: 160,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90,
                      right: 0,
                      child: Transform.rotate(
                        angle: -0.4,
                        child: Image.asset(
                          AppImages.onboarding2,
                          width: 140,
                          height: 140,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      left: 50,
                      child: Transform.rotate(
                        angle: 0.0,
                        child: Image.asset(
                          AppImages.onboarding1,
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.md),
              AutoSizeText(
                "Let's\nGet Started",
                style: context.textTheme.headlineLarge?.copyWith(
                  fontSize: 48,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              AutoSizeText(
                "“Where skills meet people.”",
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnBoardingScreen(),
                    ),
                  );
                },
                child: const AutoSizeText(
                  "Join Now",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
