import 'package:flutter/material.dart';

class QuizTimerBadge extends StatelessWidget {
  const QuizTimerBadge({required this.secondsLeft, super.key});

  final int secondsLeft;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.timer_outlined),
      label: Text('${secondsLeft}s'),
    );
  }
}
