import 'package:flutter/material.dart';
import '../theme/settings_palette.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/settings_dimensions.dart';

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
            color: SettingsPalette.secondaryText(context),
            fontWeight: FontWeight.w800,
            letterSpacing: SettingsDimensions.headerBrandLetterSpacing,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          AppStrings.settings,
          style: textTheme.displaySmall?.copyWith(
            color: SettingsPalette.primaryText(context),
            fontWeight: FontWeight.w800,
            letterSpacing: SettingsDimensions.headerTitleLetterSpacing,
            height: SettingsDimensions.headerTitleHeight,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          AppStrings.settingsSubtitle,
          style: textTheme.bodyLarge?.copyWith(
            color: SettingsPalette.secondaryText(context),
            height: SettingsDimensions.headerSubtitleHeight,
            letterSpacing: SettingsDimensions.headerSubtitleLetterSpacing,
          ),
        ),
      ],
    );
  }
}
