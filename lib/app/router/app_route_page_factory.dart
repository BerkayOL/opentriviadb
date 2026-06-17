import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_motion.dart';
import '../../features/app_shell/presentation/constants/app_shell_dimensions.dart';

abstract final class AppRoutePageFactory {
  static Page<void> buildShellPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: AppMotion.normal,
      reverseTransitionDuration: AppMotion.fast,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        final scaleAnimation = Tween<double>(
          begin: AppShellDimensions.pageScaleBegin,
          end: AppShellDimensions.pageScaleEnd,
        ).animate(curvedAnimation);

        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(scale: scaleAnimation, child: child),
        );
      },
    );
  }
}
