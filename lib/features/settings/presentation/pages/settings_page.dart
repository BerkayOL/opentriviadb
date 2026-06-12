import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../widgets/theme_mode_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: AppCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ThemeModeTile(
                  title: 'System theme',
                  selected: true,
                  onTap: _noop,
                ),
                ThemeModeTile(
                  title: 'Light theme',
                  selected: false,
                  onTap: _noop,
                ),
                ThemeModeTile(
                  title: 'Dark theme',
                  selected: false,
                  onTap: _noop,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void _noop() {}
}
