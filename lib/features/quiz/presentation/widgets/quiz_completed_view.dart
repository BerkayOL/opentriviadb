import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'quiz_action_button.dart';
import '../resolvers/quiz_result_resolver.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../constants/quiz_dimensions.dart';
import '../cubits/quiz_state.dart';
import '../theme/quiz_palette.dart';

class QuizCompletedView extends StatelessWidget {
  const QuizCompletedView({required this.state, super.key});

  final QuizState state;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scoreRatio = QuizResultResolver.scoreRatio(
      score: state.score,
      totalQuestions: state.totalQuestions,
    );

    final resultTitle = QuizResultResolver.title(scoreRatio);
    final resultIcon = QuizResultResolver.icon(scoreRatio);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: QuizDimensions.completedCardMaxWidth,
          ),
          child: AppCard(
            color: QuizPalette.cardColor(context),
            borderColor: QuizPalette.cardBorder(context),
            borderRadius: QuizDimensions.completedCardRadius,
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: QuizPalette.accent(
                      context,
                    ).withValues(alpha: QuizDimensions.completedIconFillAlpha),
                    borderRadius: BorderRadius.circular(
                      QuizDimensions.completedIconRadius,
                    ),
                    border: Border.all(
                      color: QuizPalette.accent(context).withValues(
                        alpha: QuizDimensions.completedIconBorderAlpha,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Icon(
                      resultIcon,
                      color: QuizPalette.accent(context),
                      size: QuizDimensions.completedIconSize,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  resultTitle,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall?.copyWith(
                    color: QuizPalette.primaryText(context),
                    fontWeight: FontWeight.w900,
                    letterSpacing: QuizDimensions.completedTitleLetterSpacing,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  AppStrings.quizScoreResult(state.score, state.totalQuestions),
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: QuizPalette.secondaryText(context),
                    fontWeight: FontWeight.w600,
                    height: QuizDimensions.completedScoreHeight,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                QuizActionButton(
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
