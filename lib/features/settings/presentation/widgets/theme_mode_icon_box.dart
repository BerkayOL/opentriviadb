import 'package:flutter/material.dart';

import '../../../../core/theme/app_motion.dart';
import '../constants/settings_dimensions.dart';
import '../theme/settings_palette.dart';

class ThemeModeIconBox extends StatelessWidget {
  const ThemeModeIconBox({
    required this.icon,
    required this.selected,
    super.key,
  });

  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final iconColor = selected
        ? SettingsPalette.accent(context)
        : SettingsPalette.secondaryText(context);

    return AnimatedContainer(
      duration: AppMotion.quick,
      curve: Curves.easeOutCubic,
      width: SettingsDimensions.tileIconBoxSize,
      height: SettingsDimensions.tileIconBoxSize,
      decoration: BoxDecoration(
        color: SettingsPalette.iconBoxFill(context, selected: selected),
        borderRadius: BorderRadius.circular(
          SettingsDimensions.tileIconBoxRadius,
        ),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: SettingsDimensions.tileIconSize,
      ),
    );
  }
}
