import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';
import 'package:skill_swap/utils/constants/sizes.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const MessageCard({
    super.key,
    required this.message,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md, vertical: AppSizes.sm),
        margin: const EdgeInsets.symmetric(vertical: 5),
        constraints: BoxConstraints(maxWidth: context.screenWidth * 0.65),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.deepPurple.shade300 : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppSizes.md),
            topRight: const Radius.circular(AppSizes.md),
            bottomLeft: Radius.circular(isSentByMe ? AppSizes.md : 0),
            bottomRight: Radius.circular(isSentByMe ? 0 : AppSizes.md),
          ),
        ),
        child: AutoSizeText(
          message,
          style: TextStyle(
            color: isSentByMe ? Colors.white : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
