import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../constants/splash_dimensions.dart';
import '../theme/splash_palette.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    if (isDark) {
      return Image.asset(
        AppAssets.logoForeground,
        width: SplashDimensions.logoDarkWidth,
        fit: BoxFit.contain,
      );
    }

    return Container(
      width: SplashDimensions.logoLightSurfaceSize,
      height: SplashDimensions.logoLightSurfaceSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: SplashPalette.logoSurfaceGradient,
        ),
        borderRadius: BorderRadius.circular(
          SplashDimensions.logoLightSurfaceRadius,
        ),
      ),
      child: Image.asset(
        AppAssets.logoForeground,
        width: SplashDimensions.logoLightWidth,
        fit: BoxFit.contain,
      ),
    );
  }
}
