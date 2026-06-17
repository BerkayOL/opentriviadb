import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_motion.dart';
import '../constants/app_shell_dimensions.dart';
import '../widgets/floating_nav_bar.dart';

class AppShellPage extends StatelessWidget {
  const AppShellPage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: AppMotion.normal,
              reverseDuration: AppMotion.fast,
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              layoutBuilder: (currentChild, previousChildren) {
                return currentChild ?? const SizedBox.shrink();
              },
              transitionBuilder: (child, animation) {
                final slideAnimation =
                    Tween<Offset>(
                      begin: AppShellDimensions.pageSlideBegin,
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    );

                final scaleAnimation =
                    Tween<double>(
                      begin: AppShellDimensions.pageScaleBegin,
                      end: AppShellDimensions.pageScaleEnd,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    );

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: ScaleTransition(scale: scaleAnimation, child: child),
                  ),
                );
              },
              child: KeyedSubtree(key: ValueKey(location), child: child),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: FloatingNavBar(),
          ),
        ],
      ),
    );
  }
}
