import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/model/gender_model.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({
    super.key,
    this.selectedGender,
    this.onGenderSelected,
  });

  final String? selectedGender;
  final Function(String)? onGenderSelected;

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  List<GenderOptionModel> genderOptions = [
    GenderOptionModel(
      gender: "male",
      primaryColor: Colors.blue,
      secondaryColor: Colors.blueAccent,
      shadeColor: Colors.blue.shade50,
      icon: Icons.male_rounded,
    ),
    GenderOptionModel(
      gender: "female",
      primaryColor: Colors.pink,
      secondaryColor: Colors.pinkAccent,
      shadeColor: Colors.pink.shade50,
      icon: Icons.female_rounded,
    ),
    GenderOptionModel(
      gender: "others",
      primaryColor: Colors.purple,
      secondaryColor: Colors.deepPurpleAccent,
      shadeColor: Colors.purple.shade50,
      icon: Icons.transgender_rounded,
    ),
    GenderOptionModel(
      gender: "not to say",
      primaryColor: Colors.orange,
      secondaryColor: Colors.orangeAccent,
      shadeColor: Colors.yellow.shade50,
      icon: Icons.help_outline_rounded,
    ),
  ];

  late String? selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen.shade50,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 72),
            AutoSizeText(
              "What's your gender?",
              style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w600, color: Colors.grey.shade800),
            ),
            const SizedBox(height: AppSizes.xl),
            ...genderOptions.map((option) {
              return GenderOption(
                option: option,
                isSelected: selectedGender == option.gender,
                onTap: () {
                  if (mounted) {
                    setState(() {
                      selectedGender = option.gender;
                    });
                    widget.onGenderSelected?.call(option.gender);
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class GenderOption extends StatelessWidget {
  final GenderOptionModel option;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderOption({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.padding),
        margin: const EdgeInsets.fromLTRB(36.0, 0.0, 36.0, AppSizes.sm),
        decoration: BoxDecoration(
          color: isSelected ? option.shadeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? option.secondaryColor : Colors.grey.shade500,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [option.primaryColor, option.secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: option.primaryColor.withAlpha(92),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Icon(
                  option.icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.md),
            AutoSizeText(
              option.gender,
              style: context.textTheme.titleSmall?.copyWith(
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
