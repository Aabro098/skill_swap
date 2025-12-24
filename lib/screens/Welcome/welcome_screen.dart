import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/screens/Welcome/OnBoarding/liquid_swipe.dart';
import 'package:skill_swap/utils/constants/colors.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.lightPrimary,
                AppColors.lightSecondary,
              ],
              stops: [0.0, 0.4],
            ),
          ),
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
                        left: context.screenWidth * 0.25,
                        child: Transform.rotate(
                          angle: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Image.asset(
                              AppImages.main,
                              width: 240,
                              height: 240,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: AutoSizeText(
                    "Let's\nGet Started",
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontSize: 48,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: AutoSizeText(
                    "“Where skills meet people.”",
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.xl * 2),
                // const Spacer(),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.black87,
                //   ),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const OnBoardingScreen(),
                //       ),
                //     );
                //   },
                //   child: const AutoSizeText(
                //     "Join Now",
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
