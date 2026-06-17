import 'package:flutter/material.dart';

import '../constants/splash_dimensions.dart';
import '../theme/splash_palette.dart';

class SplashBackgroundGlows extends StatelessWidget {
  const SplashBackgroundGlows({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: SplashDimensions.firstGlowLeft,
          top: SplashDimensions.firstGlowTop,
          child: _SplashGlow(
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
          child: _SplashGlow(
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

class _SplashGlow extends StatelessWidget {
  const _SplashGlow({
    required this.size,
    required this.fillColor,
    required this.shadowColor,
    required this.blurRadius,
    required this.spreadRadius,
  });

  final double size;
  final Color fillColor;
  final Color shadowColor;
  final double blurRadius;
  final double spreadRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          ),
        ],
      ),
    );
  }
}
