import 'package:flutter/material.dart';

abstract final class QuizPalette {
  static const Color transparent = Colors.transparent;
  static const Color onAccent = Colors.white;

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static List<Color> backgroundGradient(BuildContext context) {
    return isDark(context)
        ? const [Color(0xFF08111F), Color(0xFF111827), Color(0xFF172554)]
        : const [Color(0xFFF8FAFC), Color(0xFFEFF6FF), Color(0xFFEDE9FE)];
  }

  static Color selectedFill(BuildContext context) {
    return accent(context).withValues(alpha: isDark(context) ? 0.14 : 0.08);
  }

  static Color selectedBorder(BuildContext context) {
    return accent(context).withValues(alpha: isDark(context) ? 0.45 : 0.34);
  }

  static Color primaryText(BuildContext context) {
    return isDark(context) ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A);
  }

  static Color secondaryText(BuildContext context) {
    return isDark(context) ? const Color(0xFF94A3B8) : const Color(0xFF475569);
  }

  static Color cardColor(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF0F172A).withValues(alpha: 0.72)
        : Colors.white.withValues(alpha: 0.86);
  }

  static Color cardBorder(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFCBD5E1).withValues(alpha: 0.72);
  }

  static Color optionFill(BuildContext context) {
    return isDark(context) ? const Color(0xFF182235) : const Color(0xFFF8FAFC);
  }

  static Color optionBorder(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.12)
        : const Color(0xFFE2E8F0);
  }

  static Color accent(BuildContext context) {
    return isDark(context) ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);
  }

  static Color dialogBarrier() {
    return Colors.black.withValues(alpha: 0.60);
  }

  static Color dialogBackground(BuildContext context) {
    return isDark(context) ? const Color(0xFF111827) : Colors.white;
  }

  static Color dialogBorder(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.10)
        : const Color(0xFFE2E8F0);
  }

  static Color booleanSwitchShadow(BuildContext context) {
    return Colors.black.withValues(alpha: isDark(context) ? 0.22 : 0.07);
  }

  static Color booleanOptionShadow(BuildContext context) {
    return Colors.black.withValues(alpha: isDark(context) ? 0.18 : 0.06);
  }

  static Color correctFill(BuildContext context) {
    return const Color(
      0xFF22C55E,
    ).withValues(alpha: isDark(context) ? 0.18 : 0.24);
  }

  static Color correctBorder(BuildContext context) {
    return const Color(
      0xFF22C55E,
    ).withValues(alpha: isDark(context) ? 0.65 : 1);
  }

  static Color wrongFill(BuildContext context) {
    return const Color(
      0xFFEF4444,
    ).withValues(alpha: isDark(context) ? 0.18 : 0.24);
  }

  static Color wrongBorder(BuildContext context) {
    return const Color(
      0xFFEF4444,
    ).withValues(alpha: isDark(context) ? 0.65 : 1);
  }
}
