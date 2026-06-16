import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../theme/quiz_palette.dart';

Future<void> showExitQuizDialog(BuildContext context) async {
  final shouldExit = await showDialog<bool>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.60),
    builder: (dialogContext) {
      final textTheme = Theme.of(dialogContext).textTheme;
      final isDark = Theme.of(dialogContext).brightness == Brightness.dark;
      return AlertDialog(
        backgroundColor: isDark ? const Color(0xFF111827) : Colors.white,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xl,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.10)
                : const Color(0xFFE2E8F0),
          ),
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
                  dialogContext,
                ).withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: QuizPalette.accent(
                    dialogContext,
                  ).withValues(alpha: 0.28),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Icon(
                  Icons.logout_rounded,
                  color: QuizPalette.accent(dialogContext),
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                AppStrings.exitQuiz,
                style: textTheme.titleLarge?.copyWith(
                  color: QuizPalette.primaryText(dialogContext),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.4,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          AppStrings.exitQuizMessage,
          style: textTheme.bodyMedium?.copyWith(
            color: QuizPalette.secondaryText(dialogContext),
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              AppStrings.cancel,
              style: TextStyle(
                color: QuizPalette.secondaryText(dialogContext),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: QuizPalette.accent(dialogContext),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              AppStrings.exit,
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      );
    },
  );

  if (shouldExit != true || !context.mounted) {
    return;
  }

  context.go(AppRoutes.setup);
}
