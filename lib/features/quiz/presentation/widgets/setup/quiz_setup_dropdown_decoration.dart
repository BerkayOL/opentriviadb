import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../theme/quiz_setup_palette.dart';

InputDecoration dropDownDecoration(BuildContext context, String hintText) {
  final radius = BorderRadius.circular(18);

  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: QuizSetupPalette.secondaryText(context).withValues(alpha: 0.72),
      fontWeight: FontWeight.w500,
    ),
    filled: true,
    fillColor: QuizSetupPalette.fieldFill(context),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    border: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: QuizSetupPalette.fieldBorder(context)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: QuizSetupPalette.accent(context),
        width: 1.4,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.4,
      ),
    ),
  );
}
