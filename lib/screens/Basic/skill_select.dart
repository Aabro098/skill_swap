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
    required this.title,
    required this.description,
    required this.learn,
  });

  final List<String> skills;
  final Function(List<String>) onSkillsChanged;
  final String title;
  final String description;
  final bool learn;

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
      color: widget.learn ? Colors.green.shade50 : Colors.purple.shade50,
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
              widget.title,
              style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w600, color: Colors.grey.shade800),
            ),
            const SizedBox(
              height: AppSizes.md,
            ),
            AutoSizeText(
              widget.description,
              style: context.textTheme.titleSmall
                  ?.copyWith(color: Colors.grey.shade700),
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
                          color: WidgetStatePropertyAll(Colors.grey.shade100),
                          label: Text(
                            skill,
                            style: context.textTheme.titleSmall
                                ?.copyWith(color: Colors.grey.shade800),
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
              style: context.textTheme.titleSmall
                  ?.copyWith(color: Colors.grey.shade800),
              decoration: InputDecoration(
                labelText: "Enter a skill",
                hintStyle: context.textTheme.titleSmall
                    ?.copyWith(color: Colors.grey.shade800),
                labelStyle: context.textTheme.titleSmall
                    ?.copyWith(color: Colors.grey.shade800),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
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
