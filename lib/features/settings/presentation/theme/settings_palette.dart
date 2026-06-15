import 'package:flutter/material.dart';

abstract final class SettingsPalette {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static List<Color> backgroundGradient(BuildContext context) {
    return isDark(context)
        ? const [Color(0xFF08111F), Color(0xFF111827), Color(0xFF172554)]
        : const [Color(0xFFF8FAFC), Color(0xFFEFF6FF), Color(0xFFEDE9FE)];
  }

  static Color primaryText(BuildContext context) {
    return isDark(context) ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A);
  }

  static Color secondaryText(BuildContext context) {
    return isDark(context) ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
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

  static Color tileFill(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.045)
        : const Color(0xFFF8FAFC).withValues(alpha: 0.92);
  }

  static Color tileBorder(BuildContext context) {
    return isDark(context)
        ? Colors.white.withValues(alpha: 0.055)
        : const Color(0xFFE2E8F0);
  }

  static Color accent(BuildContext context) {
    return isDark(context) ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);
  }

  static Color selectedFill(BuildContext context) {
    return accent(context).withValues(alpha: isDark(context) ? 0.14 : 0.08);
  }

  static Color selectedBorder(BuildContext context) {
    return accent(context).withValues(alpha: isDark(context) ? 0.45 : 0.34);
  }

  static Color iconBoxFill(BuildContext context, {required bool selected}) {
    if (selected) {
      return accent(context).withValues(alpha: isDark(context) ? 0.18 : 0.12);
    }

    return isDark(context)
        ? Colors.white.withValues(alpha: 0.055)
        : const Color(0xFFEFF6FF);
  }

  static Color softShadow(BuildContext context) {
    return isDark(context)
        ? Colors.black.withValues(alpha: 0.24)
        : const Color(0xFF64748B).withValues(alpha: 0.12);
  }
}
