import 'package:flutter/material.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../constants/quiz_dimensions.dart';
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
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: SizedBox(
        height: QuizDimensions.progressBarHeight,
        child: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: QuizPalette.optionFill(context)),
              child: const SizedBox.expand(),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: AnimatedContainer(
                duration: AppMotion.slow,
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
