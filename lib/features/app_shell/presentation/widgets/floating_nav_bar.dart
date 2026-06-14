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
    final location = GoRouterState.of(context).uri.path;

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppShellPalette.navBarColor(context),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppShellPalette.navBarBorder(context)),
          boxShadow: [
            BoxShadow(
              color: AppShellPalette.navShadow(context),
              blurRadius: 28,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: SizedBox(
          height: 76,
          child: Row(
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
          ),
        ),
      ),
    );
  }
}
