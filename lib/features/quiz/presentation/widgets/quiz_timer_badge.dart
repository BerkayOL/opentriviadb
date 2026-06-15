import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

import '../../../../core/theme/app_spacing.dart';
import '../theme/quiz_palette.dart';

class QuizTimerBadge extends StatelessWidget {
  const QuizTimerBadge({required this.secondsLeft, super.key});

  final int secondsLeft;

  @override
  Widget build(BuildContext context) {
    final isCritical = secondsLeft <= 5;
    final foregroundColor = isCritical
        ? QuizPalette.wrongBorder(context)
        : QuizPalette.accent(context);
    final backgroundColor = isCritical
        ? QuizPalette.wrongFill(context)
        : QuizPalette.accent(context).withValues(alpha: 0.12);
    final borderColor = isCritical
        ? QuizPalette.wrongBorder(context)
        : QuizPalette.accent(context).withValues(alpha: 0.28);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.timer_outlined, size: 18, color: foregroundColor),
            const SizedBox(width: AppSpacing.xs),
            Text(
              AppStrings.secondsLeft(secondsLeft),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
