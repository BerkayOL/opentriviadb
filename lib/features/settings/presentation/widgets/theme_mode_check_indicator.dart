import 'package:flutter/material.dart';

import '../../../../core/theme/app_motion.dart';
import '../constants/settings_dimensions.dart';
import '../theme/settings_palette.dart';

class ThemeModeCheckIndicator extends StatelessWidget {
  const ThemeModeCheckIndicator({required this.selected, super.key});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SettingsDimensions.tileCheckWidth,
      child: AnimatedOpacity(
        opacity: selected ? 1 : 0,
        duration: AppMotion.fast,
        curve: Curves.easeOutCubic,
        child: Icon(
          Icons.check_circle_rounded,
          color: SettingsPalette.accent(context),
          size: SettingsDimensions.tileIconSize,
        ),
      ),
    );
  }
}
