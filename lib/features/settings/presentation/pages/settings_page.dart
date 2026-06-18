import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/settings_palette.dart';

import '../../../../core/theme/app_spacing.dart';
import '../constants/settings_dimensions.dart';
import '../cubits/theme_cubit.dart';
import '../cubits/theme_state.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeCubit, ThemeState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage &&
          current.errorMessage != null,
      listener: (context, state) {
        final message = state.errorMessage;
        if (message == null) {
          return;
        }

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
        context.read<ThemeCubit>().clearErrorMessage();
      },
      child: Scaffold(
        body: SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: SettingsPalette.backgroundGradient(context),
              ),
            ),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  SettingsDimensions.pageBottomPadding,
                ),
                children: const [
                  SettingsHeader(),
                  SizedBox(height: AppSpacing.xl),
                  SettingsCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
