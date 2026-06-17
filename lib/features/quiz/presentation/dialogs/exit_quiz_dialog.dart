import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/quiz_dimensions.dart';
import '../theme/quiz_palette.dart';
import 'exit_quiz_dialog_actions.dart';
import 'exit_quiz_dialog_title.dart';

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
      title: const ExitQuizDialogTitle(),
      content: Text(
        AppStrings.exitQuizMessage,
        style: textTheme.bodyMedium?.copyWith(
          color: QuizPalette.secondaryText(context),
          fontWeight: FontWeight.w600,
          height: QuizDimensions.dialogContentHeight,
        ),
      ),
      actions: const [ExitQuizDialogActions()],
    );
  }
}
