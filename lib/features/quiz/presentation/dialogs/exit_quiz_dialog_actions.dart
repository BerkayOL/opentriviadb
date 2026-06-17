import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../theme/quiz_palette.dart';

class ExitQuizDialogActions extends StatelessWidget {
  const ExitQuizDialogActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
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
        const SizedBox(width: AppSpacing.sm),
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
