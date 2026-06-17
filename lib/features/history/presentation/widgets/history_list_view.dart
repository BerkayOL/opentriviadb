import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_date_formats.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/quiz_history_entry.dart';
import '../cubits/history_cubit.dart';
import '../dialogs/show_clear_history_dialog.dart';
import '../theme/history_palette.dart';
import 'history_entry_tile.dart';
import 'history_summary_card.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({
    super.key,
    required this.entries,
    required this.highestScore,
  });

  final List<QuizHistoryEntry> entries;
  final int highestScore;
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat(AppDateFormats.historyEntry);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HistorySummaryCard(highestScore: highestScore),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.recentQuizzes,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: HistoryPalette.primaryText(context),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final shouldClear = await showClearHistoryDialog(context);
                if (shouldClear && context.mounted) {
                  context.read<HistoryCubit>().clearHistory();
                }
              },
              icon: Icon(
                Icons.delete_outline_rounded,
                color: HistoryPalette.dangerMuted(context),
              ),
              label: Text(
                AppStrings.clear,
                style: TextStyle(
                  color: HistoryPalette.dangerMuted(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final entry in entries) ...[
          HistoryEntryTile(
            entry: entry,
            formattedDate: dateFormat.format(entry.createdAt.toLocal()),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}
