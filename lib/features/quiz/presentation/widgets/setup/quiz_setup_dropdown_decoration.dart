import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';

InputDecoration dropDownDecoration(BuildContext context, String hintText) {
  final colorScheme = Theme.of(context).colorScheme;

  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: colorScheme.primary.withValues(alpha: 0.08),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
    ),
  );
}
