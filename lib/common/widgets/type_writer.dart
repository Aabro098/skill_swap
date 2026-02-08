import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final Duration speed;
  final bool isSentByMe;

  const TypewriterText({
    super.key,
    required this.text,
    this.speed = const Duration(milliseconds: 20),
    required this.isSentByMe,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = '';
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(widget.speed, (timer) {
      if (_index >= widget.text.length) {
        timer.cancel();
        return;
      }

      if (mounted) {
        setState(() {
          _displayedText += widget.text[_index];
          _index++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      _displayedText,
      style: context.textTheme.bodyMedium?.copyWith(
        color: widget.isSentByMe ? Colors.white : Colors.black,
        fontSize: 14,
      ),
    );
  }
}
