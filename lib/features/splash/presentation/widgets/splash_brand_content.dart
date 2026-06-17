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
          Image.asset(
            AppAssets.logoForeground,
            width: SplashDimensions.logoWidth,
            fit: BoxFit.contain,
          ),
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
