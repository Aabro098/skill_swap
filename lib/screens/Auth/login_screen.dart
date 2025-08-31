import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/screens/homepage/homepage.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 192,
            child: Center(
              child: Image.asset(
                AppImages.welcome,
                height: 126,
                width: 192,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(90),
                  topRight: Radius.circular(90),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppImages.main,
                          height: 232,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        AutoSizeText(
                          "“Where skills meet people.”",
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.purple,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 232,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.green,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.sm,
                            horizontal: AppSizes.md,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.google,
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(
                              width: AppSizes.sm,
                            ),
                            Text(
                              "Sign in with Google",
                              style: context.textTheme.titleSmall?.copyWith(
                                color: Colors.green,
                              ),
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
        ],
      ),
    );
  }
}
