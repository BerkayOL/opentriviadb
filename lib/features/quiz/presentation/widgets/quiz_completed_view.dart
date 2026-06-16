import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../cubits/quiz_state.dart';
import '../theme/quiz_palette.dart';

class QuizCompletedView extends StatelessWidget {
  const QuizCompletedView({required this.state, super.key});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: AppCard(
            color: QuizPalette.cardColor(context),
            borderColor: QuizPalette.cardBorder(context),
            borderRadius: 32,
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: QuizPalette.accent(context).withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: QuizPalette.accent(
                        context,
                      ).withValues(alpha: 0.24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Icon(
                      Icons.emoji_events_rounded,
                      color: QuizPalette.accent(context),
                      size: 34,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  AppStrings.quizCompleted,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall?.copyWith(
                    color: QuizPalette.primaryText(context),
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  AppStrings.quizScoreResult(state.score, state.totalQuestions),
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: QuizPalette.secondaryText(context),
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label: AppStrings.playAgain,
                  icon: Icons.restart_alt_rounded,
                  onPressed: () => context.go(AppRoutes.setup),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
