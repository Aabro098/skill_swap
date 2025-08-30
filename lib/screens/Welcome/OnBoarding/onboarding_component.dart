import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/onboarding_model.dart';
import 'package:skill_swap/utils/constants/sizes.dart';
import 'package:skill_swap/utils/device/device_utility.dart';

class OnboardingComponent extends StatefulWidget {
  const OnboardingComponent({
    super.key,
    required this.model,
  });
  final OnboardingModel model;

  @override
  State<OnboardingComponent> createState() => _OnboardingComponentState();
}

class _OnboardingComponentState extends State<OnboardingComponent> {
  @override
  Widget build(BuildContext context) {
    final height = DeviceUtility.getScreenHeight(context);
    final width = DeviceUtility.getScreenWidth(context);
    return Container(
      color: widget.model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            widget.model.image,
            height: height * 0.3,
            width: width * 0.8,
          ),
          Column(
            children: [
              AutoSizeText(
                widget.model.title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(AppSizes.padding),
                child: AutoSizeText(
                  widget.model.description,
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
