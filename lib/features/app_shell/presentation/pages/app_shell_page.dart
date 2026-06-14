import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              duration: const Duration(milliseconds: 240),
              reverseDuration: const Duration(milliseconds: 180),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              layoutBuilder: (currentChild, previousChildren) {
                return currentChild ?? const SizedBox.shrink();
              },
              transitionBuilder: (child, animation) {
                final slideAnimation =
                    Tween<Offset>(
                      begin: const Offset(0.025, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    );

                final scaleAnimation = Tween<double>(begin: 0.992, end: 1)
                    .animate(
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
