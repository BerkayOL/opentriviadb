import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
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
      borderRadius: 30,
      padding: const EdgeInsets.all(AppSpacing.lg),
      boxShadow: [
        BoxShadow(
          color: HistoryPalette.softShadow(context),
          offset: const Offset(0, 18),
          blurRadius: 28,
        ),
      ],
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: HistoryPalette.accent(context).withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              Icons.emoji_events_rounded,
              color: HistoryPalette.accent(context),
              size: 28,
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
                const SizedBox(height: 4),
                Text(
                  AppStrings.correctAnswerCount(highestScore),
                  style: textTheme.headlineSmall?.copyWith(
                    color: HistoryPalette.primaryText(context),
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
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
