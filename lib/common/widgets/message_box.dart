import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skill_swap/common/reusables/search_text.dart';
import 'package:skill_swap/extensions/context_extensions.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    required this.hint,
    super.key,
  });

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: RoundedTextField(
              hintText: hint,
              fillColor: Colors.deepPurple.shade50,
              textColor: Colors.black,
            ),
          ),
          FittedBox(
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {},
              icon: Icon(Iconsax.send_1, color: context.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
