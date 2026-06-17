import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../theme/app_feedback_dimensions.dart';
import '../theme/app_spacing.dart';
import 'app_button.dart';
import 'app_card.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({required this.message, super.key, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppFeedbackDimensions.messageMaxWidth,
          ),
          child: AppCard(
            borderRadius: AppFeedbackDimensions.cardRadius,
            borderColor: colorScheme.error.withValues(
              alpha: AppFeedbackDimensions.errorBorderAlpha,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.error.withValues(
                      alpha: AppFeedbackDimensions.iconFillAlpha,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppFeedbackDimensions.iconContainerRadius,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: colorScheme.error,
                      size: AppFeedbackDimensions.iconSize,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  AppStrings.genericError,
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: AppFeedbackDimensions.messageTextHeight,
                  ),
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(label: AppStrings.tryAgain, onPressed: onRetry),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
