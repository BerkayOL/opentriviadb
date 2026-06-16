import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/quiz_dimensions.dart';
import '../theme/quiz_palette.dart';

class QuizActionButton extends StatelessWidget {
  const QuizActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    final accent = QuizPalette.accent(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundAlpha = isDark ? 0.22 : 0.40;
    final borderAlpha = isDark ? 0.48 : 0.64;
    return AnimatedOpacity(
      opacity: isEnabled ? 1 : 0.55,
      duration: const Duration(milliseconds: 180),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: isDark ? 0.10 : 0.12),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: QuizPalette.transparent,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Ink(
              height: QuizDimensions.quizActionButtonHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                color: accent.withValues(alpha: backgroundAlpha),
                border: Border.all(
                  color: accent.withValues(alpha: borderAlpha),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: QuizPalette.onAccent,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(icon, color: QuizPalette.onAccent, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
