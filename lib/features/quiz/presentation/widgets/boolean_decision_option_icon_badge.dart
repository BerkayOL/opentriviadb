import 'package:flutter/material.dart';

import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../constants/quiz_dimensions.dart';

class BooleanDecisionOptionIconBadge extends StatelessWidget {
  const BooleanDecisionOptionIconBadge({
    required this.icon,
    required this.accentColor,
    required this.fillColor,
    super.key,
  });

  final IconData icon;
  final Color accentColor;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: QuizDimensions.booleanIconBadgeSize,
      height: QuizDimensions.booleanIconBadgeSize,
      duration: AppMotion.normal,
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: accentColor.withValues(
            alpha: QuizDimensions.booleanIconBorderAlpha,
          ),
        ),
      ),
      child: Icon(
        icon,
        color: accentColor,
        size: QuizDimensions.booleanIconSize,
      ),
    );
  }
}
