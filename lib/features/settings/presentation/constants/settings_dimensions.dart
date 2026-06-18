import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';

abstract final class SettingsDimensions {
  static const double pageBottomPadding = 128;

  static const double headerBrandLetterSpacing = 0.8;
  static const double headerTitleLetterSpacing = -1.0;
  static const double headerTitleHeight = 1.05;
  static const double headerSubtitleLetterSpacing = 0.1;
  static const double headerSubtitleHeight = 1.42;

  static const double cardRadius = AppRadius.xxl;
  static const double cardShadowBlur = 28;
  static const Offset cardShadowOffset = Offset(0, 18);
  static const double cardTitleLetterSpacing = -0.2;
  static const double cardSubtitleHeight = 1.35;

  static const double tileRadius = AppRadius.lg;
  static const double tileSelectedShadowAlpha = 0.10;
  static const double tileShadowBlur = 18;
  static const Offset tileShadowOffset = Offset(0, 8);
  static const double tileSplashAlpha = 0.08;
  static const double tileHighlightAlpha = 0.05;
  static const double tileIconBoxSize = 44;
  static const double tileIconBoxRadius = AppRadius.md;
  static const double tileIconSize = 21;
  static const double tileTitleLetterSpacing = -0.15;
  static const double tileTitleSubtitleGap = 3;
  static const double tileSubtitleHeight = 1.35;
  static const double tileCheckWidth = 24;
  static const double selectedCheckOpacity = 1;
  static const double unselectedCheckOpacity = 0;
}
