import 'package:flutter/material.dart';

abstract final class SplashPalette {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static List<Color> backgroundGradient(BuildContext context) {
    final dark = isDark(context);

    return dark
        ? const [Color(0xFF070A1F), Color(0xFF141044), Color(0xFF24105F)]
        : const [Color(0xFFF8FAFC), Color(0xFFEFF6FF), Color(0xFFEDE9FE)];
  }

  static Color primaryText(BuildContext context) {
    return isDark(context) ? Colors.white : const Color(0xFF0F172A);
  }

  static Color secondaryText(BuildContext context) {
    return isDark(context) ? Colors.white70 : const Color(0xFF475569);
  }

  static Color progressColor(BuildContext context) {
    return isDark(context) ? Colors.white : const Color(0xFF3B82F6);
  }

  static Color progressBackground(BuildContext context) {
    return isDark(context) ? Colors.white24 : const Color(0xFFCBD5E1);
  }

  static Color firstGlowColor(BuildContext context) {
    return isDark(context)
        ? Colors.blue.withValues(alpha: 0.30)
        : const Color(0xFF60A5FA).withValues(alpha: 0.22);
  }

  static Color firstGlowFill(BuildContext context) {
    return isDark(context)
        ? Colors.blue.withValues(alpha: 0.08)
        : const Color(0xFF60A5FA).withValues(alpha: 0.10);
  }

  static Color secondGlowColor(BuildContext context) {
    return isDark(context)
        ? Colors.purple.withValues(alpha: 0.55)
        : const Color(0xFF8B5CF6).withValues(alpha: 0.20);
  }

  static Color secondGlowFill(BuildContext context) {
    return isDark(context)
        ? Colors.purple.withValues(alpha: 0.08)
        : const Color(0xFF8B5CF6).withValues(alpha: 0.08);
  }
}
