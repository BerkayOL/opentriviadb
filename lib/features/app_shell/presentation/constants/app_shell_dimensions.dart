import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';

abstract final class AppShellDimensions {
  static const double navBottomInset = 16;
  static const double navWidthFactor = 0.7;
  static const double navMaxWidth = 320;
  static const double navRadius = AppRadius.dock;
  static const double navPrimaryShadowBlur = 24;
  static const Offset navPrimaryShadowOffset = Offset(0, 8);
  static const double navAccentShadowBlur = 16;
  static const Offset navAccentShadowOffset = Offset(0, 4);
  static const double navBlurSigma = 20;
  static const double navBorderWidth = 0.5;
  static const double navHeight = 76;

  static const double itemSplashAlpha = 0.10;
  static const double itemHighlightAlpha = 0.08;
  static const double pressedScale = 0.96;
  static const double selectedSlideY = -0.06;
  static const double selectedScale = 1.04;
  static const double inactiveScale = 1;
  static const double iconShellSize = 44;
  static const double selectedBubbleSize = 44;
  static const double inactiveBubbleSize = 36;
  static const double bubbleBorderWidth = 0.8;
  static const double bubbleGlowBlur = 6;
  static const double activeIconOpacity = 1;
  static const double inactiveIconOpacity = 0.92;
  static const double selectedIconSize = 31;
  static const double inactiveIconSize = 29;
  static const double iconIndicatorGap = 4;
  static const double selectedIndicatorWidth = 22;
  static const double hiddenIndicatorWidth = 0;
  static const double indicatorHeight = 3;
  static const double indicatorGlowBlur = 4;

  static const double pageScaleBegin = 0.992;
  static const double pageScaleEnd = 1;
}
