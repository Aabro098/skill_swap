import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skill_swap/common/widgets/drawer_page.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/auth_state.dart';
import 'package:skill_swap/notifiers/auth_notifier.dart';
import 'package:skill_swap/screens/Basic/basic_complete.dart';
import 'package:skill_swap/utils/constants/colors.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';
import 'package:skill_swap/utils/helpers/helper_functions.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) async {
      final error = next.error;

      if (error != null && error.isNotEmpty) {
        showErrorSnackbar(context: context, error);
      }

      if (next.isAuthenticated == true) {
        await navigatorKey.currentState!.pushNamedAndRemoveUntil(
          DrawerPage.routeName,
          (_) => false,
        );
      }

      if (next.isProfileComplete == false) {
        await navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BasicComplete(id: next.userId ?? ''),
          ),
          (_) => false,
        );
      }
    });

    return Scaffold(
      body: Container(
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
                    style: context.textTheme.titleMedium
                        ?.copyWith(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                width: 232,
                child: authState.isLoading
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
                    : OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: AppColors.lightBackground,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.sm,
                            horizontal: AppSizes.md,
                          ),
                        ),
                        onPressed: () {
                          ref.read(authNotifierProvider.notifier).login();
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
                                color: AppColors.lightBackground,
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
    );
  }
}
