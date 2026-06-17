import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/quiz_dimensions.dart';
import '../dialogs/show_exit_quiz_dialog.dart';
import '../theme/quiz_palette.dart';
import 'quiz_progress_bar.dart';
import 'quiz_progress_header.dart';
import 'quiz_timer_badge.dart';

class QuizQuestionHeader extends StatelessWidget {
  const QuizQuestionHeader({
    required this.currentQuestion,
    required this.totalQuestions,
    required this.secondsLeft,
    super.key,
  });

  final int currentQuestion;
  final int totalQuestions;
  final int secondsLeft;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: QuizDimensions.backButtonSize,
              height: QuizDimensions.backButtonSize,
              child: Material(
                color: QuizPalette.primaryText(
                  context,
                ).withValues(alpha: QuizDimensions.backButtonFillAlpha),
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: InkWell(
                  onTap: () => showExitQuizDialog(context),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: QuizPalette.primaryText(context).withValues(
                          alpha: QuizDimensions.backButtonBorderAlpha,
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: QuizPalette.primaryText(context),
                      size: QuizDimensions.backButtonIconSize,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: QuizProgressHeader(
                currentQuestion: currentQuestion,
                totalQuestions: totalQuestions,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            QuizTimerBadge(secondsLeft: secondsLeft),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        QuizProgressBar(
          currentQuestion: currentQuestion,
          totalQuestions: totalQuestions,
        ),
      ],
    );
  }
}
