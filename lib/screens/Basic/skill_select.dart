import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class SkillsInput extends StatefulWidget {
  const SkillsInput({super.key});

  @override
  SkillsInputState createState() => SkillsInputState();
}

class SkillsInputState extends State<SkillsInput> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _skills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
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
              height: AppSizes.lg,
            ),
            if (_skills.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _skills
                    .map((skill) => Chip(
                          label: Text(
                            skill,
                            style: context.textTheme.titleSmall,
                          ),
                          side: BorderSide(
                            color: Colors.blue.shade100,
                          ),
                          deleteIconColor: Colors.red,
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () {
                            setState(() {
                              _skills.remove(skill);
                            });
                          },
                        ))
                    .toList(),
              ),
            const SizedBox(height: AppSizes.lg),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter a skill",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty &&
                    !_skills.contains(value.trim())) {
                  setState(() {
                    _skills.add(value.trim());
                    _controller.clear();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
