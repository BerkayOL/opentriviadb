import 'package:flutter/material.dart';
import 'package:opentriviadb/features/settings/presentation/theme/settings_palette.dart';

import '../../../../core/theme/app_spacing.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                128,
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
    );
  }
}
