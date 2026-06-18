import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../constants/quiz_dimensions.dart';
import '../theme/quiz_palette.dart';

class QuizLoadingView extends StatelessWidget {
  const QuizLoadingView({super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: QuizDimensions.viewEntranceBeginScale,
            end: QuizDimensions.maximumProgress,
          ),
          duration: AppMotion.slow,
          curve: Curves.easeOutCubic,
          builder: (context, scale, child) {
            final opacity =
                ((scale - QuizDimensions.viewEntranceBeginScale) /
                        (QuizDimensions.maximumProgress -
                            QuizDimensions.viewEntranceBeginScale))
                    .clamp(
                      QuizDimensions.minimumProgress,
                      QuizDimensions.maximumProgress,
                    )
                    .toDouble();

            return Opacity(
              opacity: opacity,
              child: Transform.scale(scale: scale, child: child),
            );
          },
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
      ),
    );
  }
}
