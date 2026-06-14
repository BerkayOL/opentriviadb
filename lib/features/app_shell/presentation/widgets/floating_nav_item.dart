import 'package:flutter/material.dart';

import '../theme/app_shell_palette.dart';

class FloatingNavItem extends StatefulWidget {
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
  State<FloatingNavItem> createState() => _FloatingNavItemState();
}

class _FloatingNavItemState extends State<FloatingNavItem> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed == value) return;
    setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final itemColor = widget.isSelected
        ? AppShellPalette.activeIcon(context)
        : AppShellPalette.passiveIcon(context, pressed: _isPressed);

    return Expanded(
      child: Semantics(
        label: widget.label,
        button: true,
        selected: widget.isSelected,
        child: Tooltip(
          message: widget.label,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            child: InkWell(
              onTap: widget.onTap,
              onTapDown: (_) => _setPressed(true),
              onTapCancel: () => _setPressed(false),
              onTapUp: (_) => _setPressed(false),
              borderRadius: BorderRadius.circular(999),
              splashColor: AppShellPalette.selectedGradient.first.withValues(
                alpha: 0.10,
              ),
              highlightColor: AppShellPalette.selectedGradient.last.withValues(
                alpha: 0.08,
              ),
              child: AnimatedScale(
                scale: _isPressed ? 0.96 : 1.0,
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                child: SizedBox(
                  height: 76,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSlide(
                        offset: widget.isSelected
                            ? const Offset(0, -0.06)
                            : Offset.zero,
                        duration: const Duration(milliseconds: 320),
                        curve: Curves.easeOutCubic,
                        child: AnimatedScale(
                          scale: widget.isSelected ? 1.04 : 1,
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
                                  width: widget.isSelected ? 44 : 36,
                                  height: widget.isSelected ? 44 : 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.isSelected
                                        ? AppShellPalette.activeBubbleFill(
                                            context,
                                          )
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: widget.isSelected
                                          ? AppShellPalette.activeBubbleBorder(
                                              context,
                                            )
                                          : Colors.transparent,
                                      width: 0.8,
                                    ),
                                    boxShadow: widget.isSelected
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
                                  opacity: widget.isSelected ? 1 : 0.92,
                                  duration: const Duration(milliseconds: 240),
                                  curve: Curves.easeOutCubic,
                                  child: Icon(
                                    widget.icon,
                                    size: widget.isSelected ? 31 : 29,
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
                        width: widget.isSelected ? 22 : 0,
                        height: 3,
                        decoration: BoxDecoration(
                          gradient: widget.isSelected
                              ? const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: AppShellPalette.selectedGradient,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: widget.isSelected
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
      ),
    );
  }
}
