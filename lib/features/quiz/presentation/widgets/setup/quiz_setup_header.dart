import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_spacing.dart';

class SetupHeader extends StatelessWidget {
  const SetupHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.brandName,
                style: textTheme.labelLarge?.copyWith(
                  color: Colors.white70,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            _HeaderActionButton(
              tooltip: AppStrings.history,
              icon: Icons.history_rounded,
              onPressed: () => context.push(AppRoutes.history),
            ),
            const SizedBox(width: AppSpacing.sm),
            _HeaderActionButton(
              tooltip: AppStrings.settings,
              icon: Icons.settings_rounded,
              onPressed: () => context.push(AppRoutes.settings),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          AppStrings.appName,
          style: textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          AppStrings.setupSubtitle,
          style: textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.76),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.12),
        foregroundColor: Colors.white,
        fixedSize: const Size(44, 44),
      ),
      icon: Icon(icon),
    );
  }
}
