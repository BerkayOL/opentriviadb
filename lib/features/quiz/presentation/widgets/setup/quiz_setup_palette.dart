import 'package:flutter/material.dart';

class QuizSetupPalette {
  const QuizSetupPalette._();
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static List<Color> backgroundGradient(BuildContext context) {
    final dark = isDark(context);
    return dark
        ? const [Color(0xFF08111F), Color(0xFF111827), Color(0xFF172554)]
        : const [Color(0xFFF8FAFC), Color(0xFFEFF6FF), Color(0xFFEDE9FE)];
  }

  static Color pillFill(BuildContext context) {
    final dark = isDark(context);

    return dark
        ? Colors.white.withValues(alpha: 0.07)
        : Colors.white.withValues(alpha: 0.76);
  }

  static Color pillBorder(BuildContext context) {
    final dark = isDark(context);

    return dark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFCBD5E1).withValues(alpha: 0.85);
  }

  static Color primaryText(BuildContext context) {
    return isDark(context) ? Colors.white : const Color(0xFF0F172A);
  }

  static Color secondaryText(BuildContext context) {
    return isDark(context) ? Colors.white70 : const Color(0xFF475569);
  }

  static Color cardColor(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF0F172A).withValues(alpha: 0.92)
        : Colors.white.withValues(alpha: 0.88);
  }

  static Color cardBorder(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFCBD5E1).withValues(alpha: 0.75);
  }

  static Color fieldFill(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.07)
        : const Color(0xFFF1F5F9).withValues(alpha: 0.95);
  }

  static Color fieldBorder(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFCBD5E1);
  }

  static Color dropdownColor(BuildContext context) {
    return isDark(context) ? const Color(0xFF111827) : Colors.white;
  }

  static Color accent(BuildContext context) {
    return const Color(0xFF60A5FA);
  }
}
