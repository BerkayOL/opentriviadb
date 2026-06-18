import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_radius.dart';
import '../constants/quiz_dimensions.dart';

class AnswerOptionBadge extends StatelessWidget {
  const AnswerOptionBadge({
    required this.optionIndex,
    required this.backgroundColor,
    required this.borderColor,
    super.key,
  });

  final int optionIndex;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final optionLabel =
        optionIndex >= 0 && optionIndex < AppStrings.answerOptionLabels.length
        ? AppStrings.answerOptionLabels[optionIndex]
        : AppStrings.unknownAnswerOptionLabel;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        color: backgroundColor,
        border: Border.all(color: borderColor),
      ),
      child: SizedBox(
        width: QuizDimensions.optionBadgeSize,
        height: QuizDimensions.optionBadgeSize,
        child: Center(
          child: Text(
            optionLabel,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: borderColor,
              fontWeight: FontWeight.w900,
              letterSpacing: QuizDimensions.answerLabelLetterSpacing,
            ),
          ),
        ),
      ),
    );
  }
}
