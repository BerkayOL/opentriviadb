import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../quiz/presentation/widgets/setup/quiz_setup_palette.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.brandName,
          style: textTheme.titleMedium?.copyWith(
            color: QuizSetupPalette.secondaryText(context),
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          AppStrings.settings,
          style: textTheme.displaySmall?.copyWith(
            color: QuizSetupPalette.primaryText(context),
            fontWeight: FontWeight.w800,
            letterSpacing: -1.0,
            height: 1.05,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          AppStrings.settingsSubtitle,
          style: textTheme.bodyLarge?.copyWith(
            color: QuizSetupPalette.secondaryText(context),
            height: 1.42,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}
