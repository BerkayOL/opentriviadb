import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../constants/splash_dimensions.dart';
import '../theme/splash_palette.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _goToSetupAfterDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: SplashPalette.backgroundGradient(context),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: SplashDimensions.firstGlowLeft,
              top: SplashDimensions.firstGlowTop,
              child: Container(
                width: SplashDimensions.firstGlowSize,
                height: SplashDimensions.firstGlowSize,
                decoration: BoxDecoration(
                  color: SplashPalette.firstGlowFill(context),

                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: SplashPalette.firstGlowColor(context),
                      blurRadius: SplashDimensions.firstGlowBlur,
                      spreadRadius: SplashDimensions.firstGlowSpread,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: SplashDimensions.lowerGlowRight,
              bottom: SplashDimensions.lowerGlowBottom,
              child: Container(
                width: SplashDimensions.lowerGlowSize,
                height: SplashDimensions.lowerGlowSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: SplashPalette.lowerGlowFill(context),

                  boxShadow: [
                    BoxShadow(
                      color: SplashPalette.lowerGlowColor(context),
                      blurRadius: SplashDimensions.lowerGlowBlur,
                      spreadRadius: SplashDimensions.lowerGlowSpread,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: TweenAnimationBuilder<double>(
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
                        backgroundColor: SplashPalette.progressBackground(
                          context,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToSetupAfterDelay() async {
    await Future.delayed(SplashDimensions.navigationDelay);
    if (!mounted) return;
    context.go(AppRoutes.setup);
  }
}
