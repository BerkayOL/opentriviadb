import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/quiz_dimensions.dart';
import '../theme/quiz_palette.dart';

class ExitQuizDialogTitle extends StatelessWidget {
  const ExitQuizDialogTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: QuizPalette.accent(
              context,
            ).withValues(alpha: QuizDimensions.dialogIconFillAlpha),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: QuizPalette.accent(
                context,
              ).withValues(alpha: QuizDimensions.dialogIconBorderAlpha),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Icon(
              Icons.logout_rounded,
              color: QuizPalette.accent(context),
              size: QuizDimensions.dialogIconSize,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            AppStrings.exitQuiz,
            style: textTheme.titleLarge?.copyWith(
              color: QuizPalette.primaryText(context),
              fontWeight: FontWeight.w900,
              letterSpacing: QuizDimensions.dialogTitleLetterSpacing,
            ),
          ),
        ),
      ],
    );
  }
}
