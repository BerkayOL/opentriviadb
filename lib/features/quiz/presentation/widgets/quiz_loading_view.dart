import 'package:flutter/material.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/widgets/app_card.dart';
import '../constants/quiz_dimensions.dart';
import '../theme/quiz_palette.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';

class QuizLoadingView extends StatelessWidget {
  const QuizLoadingView({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: QuizDimensions.loadingCardMaxWidth,
          ),
          child: AppCard(
            color: QuizPalette.cardColor(context),
            borderColor: QuizPalette.cardBorder(context),
            borderRadius: AppRadius.xl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: QuizDimensions.loadingIndicatorSize,
                  height: QuizDimensions.loadingIndicatorSize,
                  child: CircularProgressIndicator(
                    strokeWidth: QuizDimensions.loadingIndicatorStrokeWidth,
                    color: QuizPalette.accent(context),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  AppStrings.loadingQuestions,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: QuizPalette.secondaryText(context),
                    fontWeight: FontWeight.w600,
                    height: QuizDimensions.loadingTextHeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
