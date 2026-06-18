import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/quiz_history_entry.dart';
import '../constants/history_dimensions.dart';
import '../theme/history_palette.dart';

class HistoryEntryTile extends StatelessWidget {
  const HistoryEntryTile({
    super.key,
    required this.entry,
    required this.formattedDate,
  });
  final QuizHistoryEntry entry;
  final String formattedDate;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scoreText = AppStrings.scoreFraction(
      entry.score,
      entry.totalQuestions,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(HistoryDimensions.entryTileRadius),
        color: HistoryPalette.itemFill(context),
        border: Border.all(color: HistoryPalette.itemBorder(context)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: HistoryDimensions.entryScoreBoxSize,
              height: HistoryDimensions.entryScoreBoxSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: HistoryPalette.accent(
                  context,
                ).withValues(alpha: HistoryDimensions.entryScoreBoxAlpha),
                borderRadius: BorderRadius.circular(
                  HistoryDimensions.entryTileRadius,
                ),
              ),
              child: Text(
                scoreText,
                style: textTheme.titleMedium?.copyWith(
                  color: HistoryPalette.accent(context),
                  fontWeight: FontWeight.w800,
                  letterSpacing: HistoryDimensions.entryScoreLetterSpacing,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.historyScore(entry.score, entry.totalQuestions),
                    style: textTheme.titleMedium?.copyWith(
                      color: HistoryPalette.primaryText(context),
                      fontWeight: FontWeight.w800,
                      letterSpacing: HistoryDimensions.entryTitleLetterSpacing,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    AppStrings.completedAtDate(formattedDate),
                    style: textTheme.bodySmall?.copyWith(
                      color: HistoryPalette.secondaryText(context),
                      height: HistoryDimensions.entryDateHeight,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
