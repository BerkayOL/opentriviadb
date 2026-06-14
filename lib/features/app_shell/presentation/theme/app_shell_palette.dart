import 'package:flutter/material.dart';

abstract final class AppShellPalette {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color navBarColor(BuildContext context) {
    final dark = isDark(context);

    return dark
        ? const Color(0xFF0F172A).withValues(alpha: 0.92)
        : Colors.white.withValues(alpha: 0.88);
  }

  static Color navBarBorder(BuildContext context) {
    final dark = isDark(context);

    return dark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFCBD5E1).withValues(alpha: 0.85);
  }

  static Color navItemColor(BuildContext context) {
    final dark = isDark(context);

    return dark ? Colors.white70 : const Color(0xFF475569);
  }

  static Color navShadow(BuildContext context) {
    final dark = isDark(context);

    return dark
        ? Colors.black.withValues(alpha: 0.35)
        : const Color(0xFF64748B).withValues(alpha: 0.18);
  }

  static const List<Color> selectedGradient = [
    Color(0xFF3B82F6),
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];
}
