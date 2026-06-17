import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';

import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/constants/quiz_config.dart';
import '../constants/quiz_dimensions.dart';
import '../theme/quiz_palette.dart';

class QuizTimerBadge extends StatelessWidget {
  const QuizTimerBadge({required this.secondsLeft, super.key});

  final int secondsLeft;

  @override
  Widget build(BuildContext context) {
    final isCritical = secondsLeft <= QuizConfig.timerCriticalThresholdSeconds;
    final foregroundColor = isCritical
        ? QuizPalette.wrongBorder(context)
        : QuizPalette.accent(context);
    final backgroundColor = isCritical
        ? QuizPalette.wrongFill(context)
        : QuizPalette.accent(
            context,
          ).withValues(alpha: QuizDimensions.timerNormalBackgroundAlpha);
    final borderColor = isCritical
        ? QuizPalette.wrongBorder(context)
        : QuizPalette.accent(
            context,
          ).withValues(alpha: QuizDimensions.timerNormalBorderAlpha);
    return AnimatedContainer(
      duration: AppMotion.quick,
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
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
            Icon(
              Icons.timer_outlined,
              size: QuizDimensions.timerIconSize,
              color: foregroundColor,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              AppStrings.secondsLeft(secondsLeft),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w800,
                letterSpacing: QuizDimensions.timerLetterSpacing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
