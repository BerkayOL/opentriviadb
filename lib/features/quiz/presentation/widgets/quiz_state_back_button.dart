import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../constants/quiz_dimensions.dart';
import '../theme/quiz_palette.dart';

class QuizStateBackButton extends StatelessWidget {
  const QuizStateBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: QuizDimensions.backButtonSize,
      height: QuizDimensions.backButtonSize,
      child: Material(
        color: QuizPalette.primaryText(
          context,
        ).withValues(alpha: QuizDimensions.backButtonFillAlpha),
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Tooltip(
            message: MaterialLocalizations.of(context).backButtonTooltip,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: QuizPalette.primaryText(
                    context,
                  ).withValues(alpha: QuizDimensions.backButtonBorderAlpha),
                ),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: QuizPalette.primaryText(context),
                size: QuizDimensions.backButtonIconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
