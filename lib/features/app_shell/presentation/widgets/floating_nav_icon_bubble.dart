import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_motion.dart';
import '../constants/app_shell_dimensions.dart';
import '../cubits/nav_item_press_cubit.dart';
import '../theme/app_shell_palette.dart';

class FloatingNavIconBubble extends StatelessWidget {
  const FloatingNavIconBubble({
    super.key,
    required this.icon,
    required this.isSelected,
  });

  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavItemPressCubit, bool>(
      builder: (context, pressed) {
        final itemColor = isSelected
            ? AppShellPalette.activeIcon(context)
            : AppShellPalette.passiveIcon(context, pressed: pressed);
        return SizedBox(
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
                      ? AppShellPalette.activeBubbleFill(context)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? AppShellPalette.activeBubbleBorder(context)
                        : Colors.transparent,
                    width: AppShellDimensions.bubbleBorderWidth,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppShellPalette.activeBubbleGlow(context),
                            blurRadius: AppShellDimensions.bubbleGlowBlur,
                          ),
                        ]
                      : null,
                ),
              ),
              AnimatedOpacity(
                opacity: isSelected
                    ? 1
                    : AppShellDimensions.inactiveIconOpacity,
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
        );
      },
    );
  }
}
