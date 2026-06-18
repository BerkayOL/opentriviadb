import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opentriviadb/features/app_shell/presentation/cubits/nav_item_press_cubit.dart';

import '../../../../../core/theme/app_motion.dart';
import '../../../../../core/theme/app_radius.dart';
import '../constants/app_shell_dimensions.dart';
import '../theme/app_shell_palette.dart';
import 'floating_nav_icon_bubble.dart';
import 'floating_nav_indicator.dart';

class FloatingNavItemBody extends StatelessWidget {
  const FloatingNavItemBody({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavItemPressCubit, bool>(
      builder: (context, pressed) {
        return Semantics(
          label: label,
          button: true,
          selected: isSelected,
          child: Tooltip(
            message: label,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: InkWell(
                onTap: onTap,
                onTapDown: (_) =>
                    context.read<NavItemPressCubit>().setPressed(true),
                onTapCancel: () =>
                    context.read<NavItemPressCubit>().setPressed(false),
                onTapUp: (_) =>
                    context.read<NavItemPressCubit>().setPressed(false),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                splashColor: AppShellPalette.selectedGradient.first.withValues(
                  alpha: AppShellDimensions.itemSplashAlpha,
                ),
                highlightColor: AppShellPalette.selectedGradient.last
                    .withValues(alpha: AppShellDimensions.itemHighlightAlpha),
                child: AnimatedScale(
                  scale: pressed
                      ? AppShellDimensions.pressedScale
                      : AppShellDimensions.inactiveScale,
                  duration: AppMotion.medium,
                  curve: Curves.easeOutCubic,
                  child: SizedBox(
                    height: AppShellDimensions.navHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSlide(
                          offset: isSelected
                              ? const Offset(
                                  0,
                                  AppShellDimensions.selectedSlideY,
                                )
                              : Offset.zero,
                          duration: AppMotion.slow,
                          curve: Curves.easeOutCubic,
                          child: AnimatedScale(
                            scale: isSelected
                                ? AppShellDimensions.selectedScale
                                : AppShellDimensions.inactiveScale,
                            duration: AppMotion.slow,
                            curve: Curves.easeOutCubic,
                            child: FloatingNavIconBubble(
                              icon: icon,
                              isSelected: isSelected,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppShellDimensions.iconIndicatorGap,
                        ),
                        FloatingNavIndicator(isSelected: isSelected),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
