import 'dart:ui';
import 'package:flutter/material.dart';

import '../constants/app_shell_dimensions.dart';
import '../theme/app_shell_palette.dart';
import 'floating_nav_items.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: AppShellDimensions.navBottomInset),
      child: FractionallySizedBox(
        widthFactor: AppShellDimensions.navWidthFactor,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppShellDimensions.navMaxWidth,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppShellDimensions.navRadius),
              boxShadow: [
                BoxShadow(
                  color: AppShellPalette.dockShadow(context),
                  blurRadius: AppShellDimensions.navPrimaryShadowBlur,
                  offset: AppShellDimensions.navPrimaryShadowOffset,
                ),
                BoxShadow(
                  color: AppShellPalette.dockAccentShadow(context),
                  blurRadius: AppShellDimensions.navAccentShadowBlur,
                  offset: AppShellDimensions.navAccentShadowOffset,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppShellDimensions.navRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: AppShellDimensions.navBlurSigma,
                  sigmaY: AppShellDimensions.navBlurSigma,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: AppShellPalette.dockGradient(context),
                    borderRadius: BorderRadius.circular(
                      AppShellDimensions.navRadius,
                    ),
                    border: Border.all(
                      color: AppShellPalette.dockBorder(context),
                      width: AppShellDimensions.navBorderWidth,
                    ),
                  ),
                  child: const SizedBox(
                    height: AppShellDimensions.navHeight,
                    child: FloatingNavItems(),
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
