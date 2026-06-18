import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../constants/quiz_dimensions.dart';

class BooleanDecisionOptionHelper extends StatelessWidget {
  const BooleanDecisionOptionHelper({
    required this.helperText,
    required this.supportColor,
    required this.accentColor,
    this.trailingIcon,
    super.key,
  });

  final String helperText;
  final Color supportColor;
  final Color accentColor;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (trailingIcon != null) ...[
          Icon(
            trailingIcon,
            color: accentColor,
            size: QuizDimensions.booleanTrailingIconSize,
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        Flexible(
          child: Text(
            helperText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelMedium?.copyWith(
              color: supportColor.withValues(
                alpha: QuizDimensions.booleanHelperAlpha,
              ),
              fontWeight: FontWeight.w800,
              letterSpacing: AppTypography.neutralLetterSpacing,
            ),
          ),
        ),
      ],
    );
  }
}
