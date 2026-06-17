import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/quiz_dimensions.dart';
import '../theme/quiz_palette.dart';

class ExitQuizDialog extends StatelessWidget {
  const ExitQuizDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      backgroundColor: QuizPalette.dialogBackground(context),
      surfaceTintColor: QuizPalette.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: BorderSide(color: QuizPalette.dialogBorder(context)),
      ),
      titlePadding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        0,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        0,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      title: Row(
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
      ),
      content: Text(
        AppStrings.exitQuizMessage,
        style: textTheme.bodyMedium?.copyWith(
          color: QuizPalette.secondaryText(context),
          fontWeight: FontWeight.w600,
          height: QuizDimensions.dialogContentHeight,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            AppStrings.cancel,
            style: TextStyle(
              color: QuizPalette.secondaryText(context),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: QuizPalette.accent(context),
            foregroundColor: QuizPalette.onAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            AppStrings.exit,
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}
