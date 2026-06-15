import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/quiz_history_entry.dart';
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
    final scoreText = '${entry.score}/${entry.totalQuestions}';
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        color: HistoryPalette.itemFill(context),
        border: Border.all(color: HistoryPalette.itemBorder(context)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: HistoryPalette.accent(context).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.md),
              ),
              child: Text(
                scoreText,
                style: textTheme.titleMedium?.copyWith(
                  color: HistoryPalette.accent(context),
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$scoreText ${AppStrings.correct}',
                    style: textTheme.titleMedium?.copyWith(
                      color: HistoryPalette.primaryText(context),
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${AppStrings.completedAt}: $formattedDate',
                    style: textTheme.bodySmall?.copyWith(
                      color: HistoryPalette.secondaryText(context),
                      height: 1.35,
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
