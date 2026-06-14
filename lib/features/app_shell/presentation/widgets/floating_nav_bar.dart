import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../core/constants/app_strings.dart';
import '../theme/app_shell_palette.dart';
import 'floating_nav_item.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 16),
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                  color: AppShellPalette.dockShadow(context),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: AppShellPalette.dockAccentShadow(context),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: AppShellPalette.dockGradient(context),
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(
                      color: AppShellPalette.dockBorder(context),
                      width: 0.5,
                    ),
                  ),
                  child: const SizedBox(height: 76, child: _FloatingNavItems()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingNavItems extends StatelessWidget {
  const _FloatingNavItems();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return Row(
      children: [
        FloatingNavItem(
          icon: Icons.quiz_rounded,
          label: AppStrings.home,
          isSelected: location == AppRoutes.setup,
          onTap: () => context.go(AppRoutes.setup),
        ),
        FloatingNavItem(
          icon: Icons.history_rounded,
          label: AppStrings.history,
          isSelected: location == AppRoutes.history,
          onTap: () => context.go(AppRoutes.history),
        ),
        FloatingNavItem(
          icon: Icons.settings_rounded,
          label: AppStrings.settings,
          isSelected: location == AppRoutes.settings,
          onTap: () => context.go(AppRoutes.settings),
        ),
      ],
    );
  }
}
