import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_motion.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../constants/quiz_dimensions.dart';
import '../../cubits/quiz_state.dart';
import '../../theme/quiz_palette.dart';

class BooleanAnswerFeedback extends StatelessWidget {
  const BooleanAnswerFeedback({super.key, required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final isRevealed = state.status == QuizStatus.answerRevealed;
    final isTimeout = isRevealed && state.selectedAnswer == null;
    final isCorrect = state.isAnswerCorrect == true;
    final color = isCorrect
        ? QuizPalette.correctBorder(context)
        : QuizPalette.wrongBorder(context);
    final title = isTimeout
        ? AppStrings.answerTimeoutTitle
        : isCorrect
        ? AppStrings.answerCorrectTitle
        : AppStrings.answerWrongTitle;
    final message = isTimeout
        ? AppStrings.answerTimeoutMessage
        : isCorrect
        ? AppStrings.answerCorrectMessage
        : AppStrings.answerWrongMessage;
    final icon = isCorrect
        ? Icons.check_circle_rounded
        : isTimeout
        ? Icons.timer_off_rounded
        : Icons.cancel_rounded;

    return AnimatedSwitcher(
      duration: AppMotion.quick,
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: isRevealed
          ? Container(
              key: ValueKey(title),
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: QuizPalette.isDark(context)
                      ? QuizDimensions.feedbackDarkFillAlpha
                      : QuizDimensions.feedbackLightFillAlpha,
                ),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: color.withValues(
                    alpha: QuizDimensions.feedbackBorderAlpha,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: QuizDimensions.feedbackIconSize,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: color,
                                fontWeight: FontWeight.w900,
                                letterSpacing:
                                    AppTypography.neutralLetterSpacing,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          message,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: QuizPalette.primaryText(context)
                                    .withValues(
                                      alpha: QuizDimensions.booleanHelperAlpha,
                                    ),
                                fontWeight: FontWeight.w700,
                                height: QuizDimensions.answerTextHeight,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
