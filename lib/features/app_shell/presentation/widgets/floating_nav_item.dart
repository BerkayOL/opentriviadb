import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opentriviadb/features/app_shell/presentation/cubits/nav_item_press_cubit.dart';

import '../../../../../core/theme/app_motion.dart';
import '../../../../../core/theme/app_radius.dart';
import '../constants/app_shell_dimensions.dart';
import '../theme/app_shell_palette.dart';

class FloatingNavItem extends StatelessWidget {
  const FloatingNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocProvider(
        create: (_) => NavItemPressCubit(),
        child: _FloatingNavItemBody(
          icon: icon,
          isSelected: isSelected,
          label: label,
          onTap: onTap,
        ),
      ),
    );
  }
}

class _FloatingNavItemBody extends StatelessWidget {
  const _FloatingNavItemBody({
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
        final itemColor = isSelected
            ? AppShellPalette.activeIcon(context)
            : AppShellPalette.passiveIcon(context, pressed: pressed);
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
                  scale: pressed ? AppShellDimensions.pressedScale : 1.0,
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
                            child: SizedBox(
                              width: AppShellDimensions.iconShellSize,
                              height: AppShellDimensions.iconShellSize,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: AppMotion.slow,
                                    curve: Curves.easeOutCubic,
                                    width: isSelected
                                        ? AppShellDimensions.selectedBubbleSize
                                        : AppShellDimensions.inactiveBubbleSize,
                                    height: isSelected
                                        ? AppShellDimensions.selectedBubbleSize
                                        : AppShellDimensions.inactiveBubbleSize,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? AppShellPalette.activeBubbleFill(
                                              context,
                                            )
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppShellPalette.activeBubbleBorder(
                                                context,
                                              )
                                            : Colors.transparent,
                                        width: AppShellDimensions
                                            .bubbleBorderWidth,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color:
                                                    AppShellPalette.activeBubbleGlow(
                                                      context,
                                                    ),
                                                blurRadius: AppShellDimensions
                                                    .bubbleGlowBlur,
                                              ),
                                            ]
                                          : null,
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    opacity: isSelected
                                        ? 1
                                        : AppShellDimensions
                                              .inactiveIconOpacity,
                                    duration: AppMotion.normal,
                                    curve: Curves.easeOutCubic,
                                    child: Icon(
                                      icon,
                                      size: isSelected
                                          ? AppShellDimensions.selectedIconSize
                                          : AppShellDimensions.inactiveIconSize,
                                      color: itemColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppShellDimensions.iconIndicatorGap,
                        ),
                        AnimatedContainer(
                          duration: AppMotion.slow,
                          curve: Curves.easeOutCubic,
                          width: isSelected
                              ? AppShellDimensions.selectedIndicatorWidth
                              : AppShellDimensions.hiddenIndicatorWidth,
                          height: AppShellDimensions.indicatorHeight,
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: AppShellPalette.selectedGradient,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppShellPalette.indicatorGlow(
                                        context,
                                      ),
                                      blurRadius:
                                          AppShellDimensions.indicatorGlowBlur,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
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
