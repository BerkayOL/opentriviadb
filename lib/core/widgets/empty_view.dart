import 'package:flutter/material.dart';

import '../theme/app_feedback_dimensions.dart';
import '../theme/app_spacing.dart';
import 'app_card.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({required this.title, super.key, this.message});

  final String title;
  final String? message;

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
            borderColor: colorScheme.outlineVariant.withValues(
              alpha: AppFeedbackDimensions.outlineBorderAlpha,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(
                      alpha: AppFeedbackDimensions.iconFillAlpha,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppFeedbackDimensions.iconContainerRadius,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Icon(
                      Icons.inbox_outlined,
                      color: colorScheme.primary,
                      size: AppFeedbackDimensions.iconSize,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: AppFeedbackDimensions.messageTextHeight,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
