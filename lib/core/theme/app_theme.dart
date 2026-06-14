import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.surface,
    );

    return _baseTheme(
      colorScheme,
    ).copyWith(scaffoldBackgroundColor: AppColors.lightBackground);
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.darkSurface,
    );

    return _baseTheme(
      colorScheme,
    ).copyWith(scaffoldBackgroundColor: AppColors.darkBackground);
  }

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.primaryFontFamily,
      colorScheme: colorScheme,
      textTheme: _textTheme,
      appBarTheme: const AppBarTheme(centerTitle: false),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
  );
}
