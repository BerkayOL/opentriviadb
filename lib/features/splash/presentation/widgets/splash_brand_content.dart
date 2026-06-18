import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../constants/splash_dimensions.dart';
import '../theme/splash_palette.dart';

class SplashBrandContent extends StatelessWidget {
  const SplashBrandContent({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: SplashDimensions.fadeBegin,
        end: SplashDimensions.fadeEnd,
      ),
      duration: SplashDimensions.introDuration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale:
                SplashDimensions.initialScale +
                (value * SplashDimensions.scaleDelta),
            child: child,
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _SplashLogo(isDark: SplashPalette.isDark(context)),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppStrings.appName,
            style: TextStyle(
              fontSize: SplashDimensions.titleFontSize,
              color: SplashPalette.primaryText(context),
              fontWeight: FontWeight.w700,
              fontFamily: AppTypography.displayFontFamily,
              letterSpacing: SplashDimensions.titleLetterSpacing,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppStrings.splashSubTitle,
            style: TextStyle(
              color: SplashPalette.secondaryText(context),
              fontSize: SplashDimensions.subtitleFontSize,
              fontWeight: FontWeight.w400,
              letterSpacing: SplashDimensions.subtitleLetterSpacing,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: SplashDimensions.progressWidth,
            child: LinearProgressIndicator(
              minHeight: SplashDimensions.progressMinHeight,
              color: SplashPalette.progressColor(context),
              backgroundColor: SplashPalette.progressBackground(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo({required this.isDark});

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
