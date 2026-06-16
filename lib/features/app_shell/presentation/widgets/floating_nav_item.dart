import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opentriviadb/features/app_shell/presentation/cubits/nav_item_press_cubit.dart';

import '../../../../../core/theme/app_radius.dart';
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
                  alpha: 0.10,
                ),
                highlightColor: AppShellPalette.selectedGradient.last
                    .withValues(alpha: 0.08),
                child: AnimatedScale(
                  scale: pressed ? 0.96 : 1.0,
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                  child: SizedBox(
                    height: 76,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSlide(
                          offset: isSelected
                              ? const Offset(0, -0.06)
                              : Offset.zero,
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOutCubic,
                          child: AnimatedScale(
                            scale: isSelected ? 1.04 : 1,
                            duration: const Duration(milliseconds: 320),
                            curve: Curves.easeOutCubic,
                            child: SizedBox(
                              width: 44,
                              height: 44,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 320),
                                    curve: Curves.easeOutCubic,
                                    width: isSelected ? 44 : 36,
                                    height: isSelected ? 44 : 36,
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
                                        width: 0.8,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color:
                                                    AppShellPalette.activeBubbleGlow(
                                                      context,
                                                    ),
                                                blurRadius: 6,
                                              ),
                                            ]
                                          : null,
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    opacity: isSelected ? 1 : 0.92,
                                    duration: const Duration(milliseconds: 240),
                                    curve: Curves.easeOutCubic,
                                    child: Icon(
                                      icon,
                                      size: isSelected ? 31 : 29,
                                      color: itemColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOutCubic,
                          width: isSelected ? 22 : 0,
                          height: 3,
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
                                      blurRadius: 4,
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
