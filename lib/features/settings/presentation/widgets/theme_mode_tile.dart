import 'package:flutter/material.dart';

import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/settings_dimensions.dart';
import '../theme/settings_palette.dart';
import 'theme_mode_check_indicator.dart';
import 'theme_mode_icon_box.dart';

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

    return AnimatedContainer(
      duration: AppMotion.quick,
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(SettingsDimensions.tileRadius),
        border: Border.all(color: borderColor),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: SettingsPalette.accent(context).withValues(
                    alpha: SettingsDimensions.tileSelectedShadowAlpha,
                  ),
                  blurRadius: SettingsDimensions.tileShadowBlur,
                  offset: SettingsDimensions.tileShadowOffset,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(SettingsDimensions.tileRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(SettingsDimensions.tileRadius),
          splashColor: SettingsPalette.accent(
            context,
          ).withValues(alpha: SettingsDimensions.tileSplashAlpha),
          highlightColor: SettingsPalette.accent(
            context,
          ).withValues(alpha: SettingsDimensions.tileHighlightAlpha),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                ThemeModeIconBox(icon: icon, selected: selected),
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
                          letterSpacing:
                              SettingsDimensions.tileTitleLetterSpacing,
                        ),
                      ),
                      const SizedBox(
                        height: SettingsDimensions.tileTitleSubtitleGap,
                      ),
                      Text(
                        subtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: SettingsPalette.secondaryText(context),
                          height: SettingsDimensions.tileSubtitleHeight,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                ThemeModeCheckIndicator(selected: selected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
