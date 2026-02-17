import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skill_swap/common/widgets/drawer_page.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/providers/auth_provider.dart';
import 'package:skill_swap/screens/Basic/basic_complete.dart';
import 'package:skill_swap/services/dio_client.dart';
import 'package:skill_swap/utils/constants/colors.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/app_globals.dart';
import 'package:skill_swap/utils/helpers/helper_functions.dart';
import 'package:skill_swap/utils/local_storage/secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _login() async {
    try {
      await context.read<AuthProvider>().login();
      await navigatorKey.currentState!.pushNamedAndRemoveUntil(
        DrawerPage.routeName,
        (_) => false,
      );
      return;
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);
      if (e.response?.statusCode == 400) {
        final token = e.response?.data['token'] as String;
        await saveTokenSecure(token);
        showErrorSnackbar(errorMessage);
        await navigatorKey.currentState!.pushNamedAndRemoveUntil(
          BasicComplete.routeName,
          (_) => false,
        );
      }
      return;
    } catch (e) {
      showErrorSnackbar('An unexpected error occurred.');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Consumer<AuthProvider>(builder: (context, provider, _) {
                return SizedBox(
                  width: 232,
                  child: provider.isLoading
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
                          onPressed: () async {
                            await _login();
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
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
