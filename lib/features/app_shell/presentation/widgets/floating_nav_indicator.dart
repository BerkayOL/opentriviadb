import 'package:flutter/material.dart';

import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../constants/app_shell_dimensions.dart';
import '../theme/app_shell_palette.dart';

class FloatingNavIndicator extends StatelessWidget {
  const FloatingNavIndicator({required this.isSelected, super.key});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.slow,
      curve: Curves.easeOutCubic,
      width: isSelected
          ? AppShellDimensions.selectedIndicatorWidth
          : AppShellDimensions.hiddenIndicatorWidth,
      height: AppShellDimensions.indicatorHeight,
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: AppShellPalette.selectedGradient,
              )
            : null,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppShellPalette.indicatorGlow(context),
                  blurRadius: AppShellDimensions.indicatorGlowBlur,
                ),
              ]
            : null,
      ),
    );
  }
}
