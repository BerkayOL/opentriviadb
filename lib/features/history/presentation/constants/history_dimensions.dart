import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';

abstract final class HistoryDimensions {
  static const double pageBottomPadding = 128;

  static const double headerBrandLetterSpacing = 0.8;
  static const double headerTitleLetterSpacing = -1.0;
  static const double headerTitleHeight = 1.05;
  static const double headerSubtitleLetterSpacing = 0.1;
  static const double headerSubtitleHeight = 1.42;

  static const double cardRadius = AppRadius.xxl;
  static const double cardShadowBlur = 28;
  static const Offset cardShadowOffset = Offset(0, 18);

  static const double summaryIconBoxSize = 52;
  static const double summaryIconBoxAlpha = 0.14;
  static const double summaryIconBoxRadius = 18;
  static const double summaryIconSize = 28;
  static const double summaryScoreTopGap = 4;
  static const double summaryScoreLetterSpacing = -0.8;

  static const double entryTileRadius = AppRadius.md;
  static const double entryScoreBoxSize = 56;
  static const double entryScoreBoxAlpha = 0.12;
  static const double entryScoreLetterSpacing = -0.4;
  static const double entryTitleLetterSpacing = -0.2;
  static const double entryDateHeight = 1.35;

  static const double dialogRadius = 18;
  static const double dialogTitleLetterSpacing = -0.4;
  static const double dialogContentHeight = 1.4;
}
