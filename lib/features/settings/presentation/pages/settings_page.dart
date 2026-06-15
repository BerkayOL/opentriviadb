import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../quiz/presentation/widgets/setup/quiz_setup_palette.dart';
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
              colors: QuizSetupPalette.backgroundGradient(context),
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
