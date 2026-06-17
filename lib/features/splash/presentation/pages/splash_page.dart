import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/app_routes.dart';
import '../constants/splash_dimensions.dart';
import '../theme/splash_palette.dart';
import '../widgets/splash_background_glows.dart';
import '../widgets/splash_brand_content.dart';

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
        child: const Stack(
          alignment: Alignment.center,
          children: [SplashBackgroundGlows(), SplashBrandContent()],
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
