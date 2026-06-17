import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/history_dimensions.dart';
import '../theme/history_palette.dart';

Future<bool> showClearHistoryDialog(BuildContext context) async {
  final shouldClear = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: HistoryPalette.cardColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HistoryDimensions.dialogRadius),
          side: BorderSide(color: HistoryPalette.cardBorder(context)),
        ),
        title: Text(
          AppStrings.clearHistory,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: HistoryPalette.primaryText(context),
            fontWeight: FontWeight.w900,
            letterSpacing: HistoryDimensions.dialogTitleLetterSpacing,
          ),
        ),
        content: Text(
          AppStrings.clearHistoryConfirmMessage,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: HistoryPalette.secondaryText(context),
            height: HistoryDimensions.dialogContentHeight,
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.md,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              AppStrings.cancel,
              style: TextStyle(
                color: HistoryPalette.secondaryText(context),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
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
    },
  );
  return shouldClear ?? false;
}
