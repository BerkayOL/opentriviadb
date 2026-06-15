import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../theme/quiz_palette.dart';
import 'answer_option_status.dart';

class AnswerOptionCard extends StatelessWidget {
  const AnswerOptionCard({
    required this.answer,
    required this.onTap,
    required this.status,
    required this.optionIndex,
    super.key,
  });
  final String answer;
  final VoidCallback onTap;
  final AnswerOptionStatus status;
  final int optionIndex;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final borderRadius = BorderRadius.circular(AppSpacing.md);
    final shouldLift = status == AnswerOptionStatus.selected;
    final backgroundColor = switch (status) {
      AnswerOptionStatus.idle => QuizPalette.optionFill(context),
      AnswerOptionStatus.selected => QuizPalette.selectedFill(context),
      AnswerOptionStatus.correct => QuizPalette.correctFill(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongFill(context),
    };

    final borderColor = switch (status) {
      AnswerOptionStatus.idle => QuizPalette.optionBorder(context),
      AnswerOptionStatus.selected => QuizPalette.selectedBorder(context),
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
    };
    final badgeBackgroundColor = borderColor.withValues(alpha: 0.14);
    final badgeBorderColor = borderColor.withValues(alpha: 0.85);
    final trailingIcon = switch (status) {
      AnswerOptionStatus.correct => Icons.check_circle_rounded,
      AnswerOptionStatus.wrong => Icons.cancel_rounded,
      _ => null,
    };

    final trailingIconColor = switch (status) {
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
      _ => null,
    };
    final labels = ['A', 'B', 'C', 'D'];
    final optionLabel = optionIndex < labels.length ? labels[optionIndex] : '?';
    return AnimatedScale(
      scale: shouldLift ? 1.02 : 1.0,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: borderColor),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                      color: badgeBackgroundColor,
                      border: Border.all(color: badgeBorderColor),
                    ),

                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: Center(
                        child: Text(
                          optionLabel,
                          style: textTheme.labelLarge?.copyWith(
                            color: badgeBorderColor,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      answer,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge?.copyWith(
                        color: QuizPalette.primaryText(context),
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Icon(trailingIcon, color: trailingIconColor, size: 22),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
