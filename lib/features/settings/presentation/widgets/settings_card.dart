import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../quiz/presentation/widgets/setup/quiz_setup_palette.dart';
import '../cubits/theme_cubit.dart';
import '../cubits/theme_state.dart';
import 'theme_mode_tile.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.appearance,
                style: textTheme.titleLarge?.copyWith(
                  color: QuizSetupPalette.primaryText(context),
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                AppStrings.themeSectionSubtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: QuizSetupPalette.secondaryText(context),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              ThemeModeTile(
                subtitle: AppStrings.defaultSystemSubTitle,
                icon: Icon(Icons.brightness_medium_rounded),
                title: AppStrings.systemTheme,
                selected: state.themeMode == ThemeMode.system,
                onTap: () {
                  context.read<ThemeCubit>().changeThemeMode(ThemeMode.system);
                },
              ),
              ThemeModeTile(
                subtitle: AppStrings.lightSystemSubTitle,
                icon: Icon(Icons.light_mode_rounded),
                title: AppStrings.lightTheme,
                selected: state.themeMode == ThemeMode.light,
                onTap: () {
                  context.read<ThemeCubit>().changeThemeMode(ThemeMode.light);
                },
              ),
              ThemeModeTile(
                icon: Icon(Icons.dark_mode_rounded),
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
