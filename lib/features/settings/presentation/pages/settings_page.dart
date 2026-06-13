import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/theme_cubit.dart';
import '../cubits/theme_state.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../widgets/theme_mode_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) => Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: AppCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ThemeModeTile(
                    title: 'System theme',
                    selected: state.themeMode == ThemeMode.system,
                    onTap: () {
                      context.read<ThemeCubit>().changeThemeMode(
                        ThemeMode.system,
                      );
                    },
                  ),
                  ThemeModeTile(
                    title: 'Light theme',
                    selected: state.themeMode == ThemeMode.light,
                    onTap: () {
                      context.read<ThemeCubit>().changeThemeMode(
                        ThemeMode.light,
                      );
                    },
                  ),
                  ThemeModeTile(
                    title: 'Dark theme',
                    selected: state.themeMode == ThemeMode.dark,
                    onTap: () {
                      context.read<ThemeCubit>().changeThemeMode(
                        ThemeMode.dark,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
