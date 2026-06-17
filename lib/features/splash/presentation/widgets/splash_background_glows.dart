import 'package:flutter/material.dart';

import '../constants/splash_dimensions.dart';
import '../theme/splash_palette.dart';
import 'splash_glow.dart';

class SplashBackgroundGlows extends StatelessWidget {
  const SplashBackgroundGlows({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: SplashDimensions.firstGlowLeft,
          top: SplashDimensions.firstGlowTop,
          child: SplashGlow(
            size: SplashDimensions.firstGlowSize,
            fillColor: SplashPalette.firstGlowFill(context),
            shadowColor: SplashPalette.firstGlowColor(context),
            blurRadius: SplashDimensions.firstGlowBlur,
            spreadRadius: SplashDimensions.firstGlowSpread,
          ),
        ),
        Positioned(
          right: SplashDimensions.lowerGlowRight,
          bottom: SplashDimensions.lowerGlowBottom,
          child: SplashGlow(
            size: SplashDimensions.lowerGlowSize,
            fillColor: SplashPalette.lowerGlowFill(context),
            shadowColor: SplashPalette.lowerGlowColor(context),
            blurRadius: SplashDimensions.lowerGlowBlur,
            spreadRadius: SplashDimensions.lowerGlowSpread,
          ),
        ),
      ],
    );
  }
}
