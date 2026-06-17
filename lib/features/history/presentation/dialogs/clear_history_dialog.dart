import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/history_dimensions.dart';
import '../theme/history_palette.dart';

class ClearHistoryDialog extends StatelessWidget {
  const ClearHistoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      backgroundColor: HistoryPalette.cardColor(context),
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(HistoryDimensions.dialogRadius),
        side: BorderSide(color: HistoryPalette.cardBorder(context)),
      ),
      titlePadding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        0,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        0,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      title: Text(
        AppStrings.clearHistory,
        style: textTheme.titleLarge?.copyWith(
          color: HistoryPalette.primaryText(context),
          fontWeight: FontWeight.w900,
          letterSpacing: HistoryDimensions.dialogTitleLetterSpacing,
        ),
      ),
      content: Text(
        AppStrings.clearHistoryConfirmMessage,
        style: textTheme.bodyMedium?.copyWith(
          color: HistoryPalette.secondaryText(context),
          height: HistoryDimensions.dialogContentHeight,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            AppStrings.cancel,
            style: TextStyle(
              color: HistoryPalette.secondaryText(context),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            AppStrings.clear,
            style: TextStyle(
              color: HistoryPalette.danger(context),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
