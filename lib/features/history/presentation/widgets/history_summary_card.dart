import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../constants/history_dimensions.dart';
import '../theme/history_palette.dart';

class HistorySummaryCard extends StatelessWidget {
  const HistorySummaryCard({required this.highestScore, super.key});

  final int highestScore;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      color: HistoryPalette.cardColor(context),
      borderColor: HistoryPalette.cardBorder(context),
      borderRadius: HistoryDimensions.cardRadius,
      padding: const EdgeInsets.all(AppSpacing.lg),
      boxShadow: [
        BoxShadow(
          color: HistoryPalette.softShadow(context),
          offset: HistoryDimensions.cardShadowOffset,
          blurRadius: HistoryDimensions.cardShadowBlur,
        ),
      ],
      child: Row(
        children: [
          Container(
            width: HistoryDimensions.summaryIconBoxSize,
            height: HistoryDimensions.summaryIconBoxSize,
            decoration: BoxDecoration(
              color: HistoryPalette.accent(
                context,
              ).withValues(alpha: HistoryDimensions.summaryIconBoxAlpha),
              borderRadius: BorderRadius.circular(
                HistoryDimensions.summaryIconBoxRadius,
              ),
            ),
            child: Icon(
              Icons.emoji_events_rounded,
              color: HistoryPalette.accent(context),
              size: HistoryDimensions.summaryIconSize,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.highestScore,
                  style: textTheme.bodyMedium?.copyWith(
                    color: HistoryPalette.secondaryText(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: HistoryDimensions.summaryScoreTopGap),
                Text(
                  AppStrings.correctAnswerCount(highestScore),
                  style: textTheme.headlineSmall?.copyWith(
                    color: HistoryPalette.primaryText(context),
                    fontWeight: FontWeight.w900,
                    letterSpacing: HistoryDimensions.summaryScoreLetterSpacing,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
