import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../theme/settings_palette.dart';

class ThemeModeTile extends StatelessWidget {
  const ThemeModeTile({
    required this.title,
    required this.selected,
    required this.icon,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String subtitle;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final borderColor = selected
        ? SettingsPalette.selectedBorder(context)
        : SettingsPalette.tileBorder(context);

    final backgroundColor = selected
        ? SettingsPalette.selectedFill(context)
        : SettingsPalette.tileFill(context);

    final iconColor = selected
        ? SettingsPalette.accent(context)
        : SettingsPalette.secondaryText(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: SettingsPalette.accent(
                    context,
                  ).withValues(alpha: 0.10),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: SettingsPalette.accent(context).withValues(alpha: 0.08),
          highlightColor: SettingsPalette.accent(
            context,
          ).withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: SettingsPalette.iconBoxFill(
                      context,
                      selected: selected,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: iconColor, size: 21),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                          color: SettingsPalette.primaryText(context),
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.15,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: SettingsPalette.secondaryText(context),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                SizedBox(
                  width: 24,
                  child: AnimatedOpacity(
                    opacity: selected ? 1 : 0,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: SettingsPalette.accent(context),
                      size: 21,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
