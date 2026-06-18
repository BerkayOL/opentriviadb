import 'package:flutter/material.dart';

import '../../../../core/theme/brand_colors.dart';

abstract final class SplashPalette {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static List<Color> backgroundGradient(BuildContext context) {
    final dark = isDark(context);

    return dark
        ? const [
            BrandColors.splashDarkStart,
            BrandColors.splashDarkCenter,
            BrandColors.splashDarkEnd,
          ]
        : const [
            BrandColors.splashLightStart,
            BrandColors.splashLightCenter,
            BrandColors.splashLightEnd,
          ];
  }

  static List<double> backgroundGradientStops(BuildContext context) {
    return isDark(context) ? const [0, 0.52, 1] : const [0, 0.55, 1];
  }

  static const List<Color> logoSurfaceGradient = [
    BrandColors.iconBackgroundDarkHighlight,
    BrandColors.iconBackgroundDarkBase,
    BrandColors.iconBackgroundDarkDepth,
  ];

  static Color primaryText(BuildContext context) {
    return isDark(context) ? Colors.white : const Color(0xFF0F172A);
  }

  static Color secondaryText(BuildContext context) {
    return isDark(context) ? Colors.white70 : const Color(0xFF475569);
  }

  static Color progressColor(BuildContext context) {
    return isDark(context) ? Colors.white : BrandColors.royalBlue;
  }

  static Color progressBackground(BuildContext context) {
    return isDark(context) ? Colors.white24 : const Color(0xFFCBD5E1);
  }

  static Color firstGlowColor(BuildContext context) {
    return isDark(context)
        ? BrandColors.royalBlue.withValues(alpha: 0.10)
        : BrandColors.lightAmbientBlue.withValues(alpha: 0.30);
  }

  static Color firstGlowFill(BuildContext context) {
    return isDark(context)
        ? BrandColors.royalBlue.withValues(alpha: 0.04)
        : BrandColors.lightAmbientBlue.withValues(alpha: 0.12);
  }

  static Color secondGlowColor(BuildContext context) {
    return isDark(context)
        ? BrandColors.deepIndigo.withValues(alpha: 0.08)
        : BrandColors.lightAmbientIndigo.withValues(alpha: 0.20);
  }

  static Color secondGlowFill(BuildContext context) {
    return isDark(context)
        ? BrandColors.deepIndigo.withValues(alpha: 0.03)
        : BrandColors.lightAmbientIndigo.withValues(alpha: 0.08);
  }

  static Color lowerGlowFill(BuildContext context) {
    return isDark(context)
        ? BrandColors.deepIndigo.withValues(alpha: 0.03)
        : BrandColors.lightAmbientIndigo.withValues(alpha: 0.08);
  }

  static Color lowerGlowColor(BuildContext context) {
    return isDark(context)
        ? BrandColors.deepIndigo.withValues(alpha: 0.06)
        : BrandColors.lightAmbientIndigo.withValues(alpha: 0.22);
  }
}
