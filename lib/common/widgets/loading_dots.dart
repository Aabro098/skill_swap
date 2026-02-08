import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skill_swap/extensions/context_extensions.dart';

class LoadingDots extends StatefulWidget {
  const LoadingDots({super.key});

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots> {
  int _dotCount = 1;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(milliseconds: 400),
      (_) {
        if (mounted) {
          setState(() {
            _dotCount = _dotCount % 3 + 1;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      '.' * _dotCount,
      style: context.textTheme.titleLarge?.copyWith(
        color: Colors.black,
      ),
    );
  }
}
