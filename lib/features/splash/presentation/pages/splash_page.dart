import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:opentriviadb/core/constants/app_strings.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF070A1F), Color(0xFF141044), Color(0xFF24105F)],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: -60,
              top: -40,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.08),

                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 60,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: -80,
              bottom: -60,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withValues(alpha: 0.08),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.6),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: 0.94 + (value * 0.06),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo/quizora_foreground.png',
                      width: 160,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Text(
                      AppStrings.appName,
                      style: TextStyle(
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppTypography.displayFontFamily,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Text(
                      'Test your knowledge',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const SizedBox(
                      width: 160,
                      child: LinearProgressIndicator(
                        minHeight: 3,
                        color: Colors.white,
                        backgroundColor: Colors.white24,
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
    await Future.delayed(const Duration(milliseconds: 2200));
    if (!mounted) return;
    context.go(AppRoutes.setup);
  }
}
