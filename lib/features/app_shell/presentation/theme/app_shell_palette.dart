import 'package:flutter/material.dart';

abstract final class AppShellPalette {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Gradient dockGradient(BuildContext context) {
    final dark = isDark(context);

    return RadialGradient(
      center: Alignment.topLeft,
      radius: 1.35,
      colors: dark
          ? [
              const Color(0xFF172033).withValues(alpha: 0.90),
              const Color(0xFF0B1220).withValues(alpha: 0.92),
            ]
          : [
              Colors.white.withValues(alpha: 0.92),
              const Color(0xFFF8FAFC).withValues(alpha: 0.88),
            ],
    );
  }

  static Color dockBorder(BuildContext context) {
    final dark = isDark(context);

    return dark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFCBD5E1).withValues(alpha: 0.72);
  }

  static Color dockShadow(BuildContext context) {
    final dark = isDark(context);

    return dark
        ? Colors.black.withValues(alpha: 0.30)
        : const Color(0xFF64748B).withValues(alpha: 0.12);
  }

  static Color dockAccentShadow(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF5B8CFF).withValues(alpha: 0.05)
        : const Color(0xFF4338CA).withValues(alpha: 0.04);
  }

  static Color passiveIcon(BuildContext context, {bool pressed = false}) {
    final dark = isDark(context);

    if (pressed) {
      return dark
          ? const Color(0xFF93C5FD).withValues(alpha: 0.82)
          : const Color(0xFF2563EB).withValues(alpha: 0.86);
    }

    return dark
        ? Colors.white.withValues(alpha: 0.58)
        : const Color(0xFF475569).withValues(alpha: 0.86);
  }

  static Color activeIcon(BuildContext context) {
    return isDark(context) ? Colors.white : const Color(0xFF0F172A);
  }

  static Color activeBubbleFill(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF5B8CFF).withValues(alpha: 0.10)
        : const Color(0xFF3B82F6).withValues(alpha: 0.10);
  }

  static Color activeBubbleBorder(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF5B8CFF).withValues(alpha: 0.12)
        : const Color(0xFF6366F1).withValues(alpha: 0.14);
  }

  static Color activeBubbleGlow(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF5B8CFF).withValues(alpha: 0.10)
        : const Color(0xFF2563EB).withValues(alpha: 0.08);
  }

  static Color indicatorGlow(BuildContext context) {
    return isDark(context)
        ? const Color(0xFF5B8CFF).withValues(alpha: 0.08)
        : const Color(0xFF4338CA).withValues(alpha: 0.07);
  }

  static const List<Color> selectedGradient = [
    Color(0xFF2563EB),
    Color(0xFF4338CA),
  ];
}
