import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../theme/app_feedback_dimensions.dart';
import '../theme/app_spacing.dart';
import 'app_card.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppFeedbackDimensions.loadingMaxWidth,
          ),
          child: AppCard(
            borderRadius: AppFeedbackDimensions.cardRadius,
            borderColor: colorScheme.outlineVariant.withValues(
              alpha: AppFeedbackDimensions.outlineBorderAlpha,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: AppFeedbackDimensions.loadingIndicatorSize,
                  height: AppFeedbackDimensions.loadingIndicatorSize,
                  child: CircularProgressIndicator(
                    strokeWidth:
                        AppFeedbackDimensions.loadingIndicatorStrokeWidth,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  message ?? AppStrings.loading,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
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
