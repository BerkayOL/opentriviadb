import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../constants/settings_dimensions.dart';
import '../cubits/theme_cubit.dart';
import '../cubits/theme_state.dart';
import '../theme/settings_palette.dart';
import 'theme_mode_tile.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return AppCard(
          color: SettingsPalette.cardColor(context),
          borderColor: SettingsPalette.cardBorder(context),
          borderRadius: SettingsDimensions.cardRadius,
          padding: const EdgeInsets.all(AppSpacing.lg),
          boxShadow: [
            BoxShadow(
              blurRadius: SettingsDimensions.cardShadowBlur,
              color: SettingsPalette.softShadow(context),
              offset: SettingsDimensions.cardShadowOffset,
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.appearance,
                style: textTheme.titleLarge?.copyWith(
                  color: SettingsPalette.primaryText(context),
                  fontWeight: FontWeight.w800,
                  letterSpacing: SettingsDimensions.cardTitleLetterSpacing,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                AppStrings.themeSectionSubtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: SettingsPalette.secondaryText(context),
                  height: SettingsDimensions.cardSubtitleHeight,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              ThemeModeTile(
                subtitle: AppStrings.defaultSystemSubTitle,
                icon: Icons.brightness_medium_rounded,
                title: AppStrings.systemTheme,
                selected: state.themeMode == ThemeMode.system,
                onTap: () {
                  context.read<ThemeCubit>().changeThemeMode(ThemeMode.system);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              ThemeModeTile(
                subtitle: AppStrings.lightSystemSubTitle,
                icon: Icons.light_mode_rounded,
                title: AppStrings.lightTheme,
                selected: state.themeMode == ThemeMode.light,
                onTap: () {
                  context.read<ThemeCubit>().changeThemeMode(ThemeMode.light);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              ThemeModeTile(
                icon: Icons.dark_mode_rounded,
                subtitle: AppStrings.darkSystemSubTitle,
                title: AppStrings.darkTheme,
                selected: state.themeMode == ThemeMode.dark,
                onTap: () {
                  context.read<ThemeCubit>().changeThemeMode(ThemeMode.dark);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
