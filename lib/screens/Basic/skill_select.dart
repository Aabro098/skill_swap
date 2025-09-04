import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class SkillsInput extends StatefulWidget {
  const SkillsInput({
    super.key,
    required this.skills,
    required this.onSkillsChanged,
  });

  final List<String> skills;
  final Function(List<String>) onSkillsChanged;

  @override
  SkillsInputState createState() => SkillsInputState();
}

class SkillsInputState extends State<SkillsInput> {
  final TextEditingController _controller = TextEditingController();
  late List<String> localSkills;

  @override
  void initState() {
    super.initState();
    localSkills = List.from(widget.skills);
  }

  final List<Color> colors = [
    Colors.red,
    Colors.indigo,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.amber,
  ];

  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 36, vertical: AppSizes.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 92,
            ),
            AutoSizeText(
              "Enter Skills",
              style: context.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: AppSizes.md,
            ),
            AutoSizeText(
              "Hi there! To help us get to know your expertise better, please take a moment to add the skills you have.",
              style: context.textTheme.titleSmall,
            ),
            const SizedBox(
              height: AppSizes.md,
            ),
            if (localSkills.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: widget.skills
                    .map((skill) => Chip(
                          label: Text(
                            skill,
                            style: context.textTheme.titleSmall,
                          ),
                          side: BorderSide(
                            color: colors[random.nextInt(colors.length)],
                          ),
                          deleteIconColor: Colors.red,
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () {
                            if (mounted) {
                              setState(() {
                                localSkills.remove(skill);
                              });
                            }
                            widget.onSkillsChanged(localSkills);
                          },
                        ))
                    .toList(),
              ),
            const SizedBox(height: AppSizes.md),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter a skill",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty &&
                    !widget.skills.contains(value.trim())) {
                  if (mounted) {
                    setState(() {
                      localSkills.add(value.trim());
                      _controller.clear();
                    });
                    widget.onSkillsChanged(localSkills);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
