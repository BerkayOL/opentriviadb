import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/history_dimensions.dart';
import '../theme/history_palette.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.brandName,
          style: textTheme.titleMedium?.copyWith(
            color: HistoryPalette.secondaryText(context),
            fontWeight: FontWeight.w800,
            letterSpacing: HistoryDimensions.headerBrandLetterSpacing,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          AppStrings.history,
          style: textTheme.displaySmall?.copyWith(
            color: HistoryPalette.primaryText(context),
            fontWeight: FontWeight.w800,
            letterSpacing: HistoryDimensions.headerTitleLetterSpacing,
            height: HistoryDimensions.headerTitleHeight,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          AppStrings.historySubtitle,
          style: textTheme.bodyLarge?.copyWith(
            color: HistoryPalette.secondaryText(context),
            height: HistoryDimensions.headerSubtitleHeight,
            letterSpacing: HistoryDimensions.headerSubtitleLetterSpacing,
          ),
        ),
      ],
    );
  }
}
