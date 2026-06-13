import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';

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
      backgroundColor: Colors.indigoAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo/quizora_foreground.png',
                width: 160,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Quizora',
                style: TextStyle(fontFamily: 'Antonio', color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Test your knowledge',
                style: TextStyle(fontFamily: 'Antonio', color: Colors.white70),
              ),
              const SizedBox(height: AppSpacing.md),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToSetupAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 1600));
    if (!mounted) return;
    context.go(AppRoutes.setup);
  }
}
