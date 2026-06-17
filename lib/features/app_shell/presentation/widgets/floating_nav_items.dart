import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import 'floating_nav_item.dart';

class FloatingNavItems extends StatelessWidget {
  const FloatingNavItems({super.key});

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
