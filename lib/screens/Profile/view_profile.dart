// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/controller/auth_controller.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/user_model.dart';
import 'package:skill_swap/services/dio_client.dart';
import 'package:skill_swap/utils/constants/colors.dart';
import 'package:skill_swap/utils/constants/image_strings.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/helpers/helper_functions.dart';

class ViewProfile extends StatefulWidget {
  final String id;
  const ViewProfile({
    required this.id,
    super.key,
  });

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  final List<Color> colors = [
    Colors.red,
    Colors.indigo,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.amber,
  ];

  final Random random = Random();
  bool _isLoading = true;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final response =
          await AuthController.instance.getUserProfile(id: widget.id);
      if (mounted) {
        setState(() {
          user = UserModel.fromJson(response);
        });
      }
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);
      showErrorSnackbar(errorMessage);
      return;
    } catch (e) {
      showErrorSnackbar('Something went wrong');
      return;
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText('Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: _isLoading
              ? const Center(
                  child: SizedBox(
                    height: AppSizes.lg,
                    width: AppSizes.lg,
                    child: CircularProgressIndicator(
                      color: AppColors.darkPrimary,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 64,
                          backgroundImage: const AssetImage(AppImages.fallback),
                          foregroundImage: NetworkImage(user?.profileUrl ?? ''),
                          onForegroundImageError: (_, __) {},
                        ),
                      ),
                      const SizedBox(height: AppSizes.lg),
                      Center(
                        child: AutoSizeText(
                          user?.name ?? '',
                          style: context.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: AppSizes.xs),
                      Center(
                        child: AutoSizeText(
                          user?.email ?? '',
                          style: context.textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      AutoSizeText(
                        context.tr('about_me'),
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSizes.xs),
                      AutoSizeText(
                        user?.description ?? '',
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: AppSizes.sm),
                      AutoSizeText(
                        "Skills",
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSizes.sm),
                      Wrap(
                        spacing: AppSizes.xs,
                        runSpacing: AppSizes.xs,
                        children: (user?.skills ?? <String>[])
                            .map<Widget>((skill) => Chip(
                                  color: WidgetStatePropertyAll(
                                      Colors.grey.shade50),
                                  padding: const EdgeInsets.all(AppSizes.xs),
                                  visualDensity: VisualDensity.comfortable,
                                  label: Text(
                                    skill,
                                    style: context.textTheme.titleSmall
                                        ?.copyWith(color: Colors.black),
                                  ),
                                  side: BorderSide(
                                      color:
                                          colors[random.nextInt(colors.length)],
                                      width: 2),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      AutoSizeText(
                        "Requested Skills",
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSizes.sm),
                      Wrap(
                        spacing: AppSizes.xs,
                        runSpacing: AppSizes.xs,
                        children: (user?.requestedSkills ?? <String>[])
                            .map<Widget>(
                              (skill) => Chip(
                                color:
                                    WidgetStatePropertyAll(Colors.grey.shade50),
                                padding: const EdgeInsets.all(AppSizes.xs),
                                visualDensity: VisualDensity.comfortable,
                                label: Text(
                                  skill,
                                  style: context.textTheme.titleSmall
                                      ?.copyWith(color: Colors.black),
                                ),
                                side: BorderSide(
                                    color:
                                        colors[random.nextInt(colors.length)],
                                    width: 2),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
