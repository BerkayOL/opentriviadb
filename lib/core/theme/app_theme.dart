import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_feedback_dimensions.dart';
import 'app_radius.dart';
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(
            AppFeedbackDimensions.defaultButtonHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
      ),
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: AppTypography.displayLargeSize,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontSize: AppTypography.displayMediumSize,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      fontSize: AppTypography.displaySmallSize,
      fontWeight: FontWeight.w700,
    ),
    headlineLarge: TextStyle(
      fontSize: AppTypography.headlineLargeSize,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontSize: AppTypography.headlineMediumSize,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      fontSize: AppTypography.headlineSmallSize,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontSize: AppTypography.titleLargeSize,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontSize: AppTypography.titleMediumSize,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontSize: AppTypography.titleSmallSize,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: AppTypography.bodyLargeSize,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: AppTypography.bodyMediumSize,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: AppTypography.bodySmallSize,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontSize: AppTypography.labelLargeSize,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontSize: AppTypography.labelMediumSize,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      fontSize: AppTypography.labelSmallSize,
      fontWeight: FontWeight.w600,
    ),
  );
}
