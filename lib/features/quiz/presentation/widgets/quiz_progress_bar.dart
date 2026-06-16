import 'package:flutter/material.dart';
import '../theme/quiz_palette.dart';

class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({
    required this.currentQuestion,
    required this.totalQuestions,
    super.key,
  });

  final int currentQuestion;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    final progress = totalQuestions == 0
        ? 0.0
        : (currentQuestion / totalQuestions).clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 8,
        child: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: QuizPalette.optionFill(context)),
              child: const SizedBox.expand(),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
                decoration: BoxDecoration(color: QuizPalette.accent(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
