import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/quiz_dimensions.dart';
import '../models/answer_option_status.dart';
import '../theme/quiz_palette.dart';

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
    final borderRadius = BorderRadius.circular(AppRadius.md);
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
    final badgeBackgroundColor = switch (status) {
      AnswerOptionStatus.idle => QuizPalette.secondaryText(
        context,
      ).withValues(alpha: 0.22),
      AnswerOptionStatus.selected => QuizPalette.selectedFill(context),
      AnswerOptionStatus.correct => QuizPalette.correctFill(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongFill(context),
    };
    final answerTextColor = switch (status) {
      AnswerOptionStatus.idle => QuizPalette.primaryText(context),
      AnswerOptionStatus.selected => QuizPalette.primaryText(context),
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
    };
    final badgeBorderColor = switch (status) {
      AnswerOptionStatus.idle => QuizPalette.secondaryText(
        context,
      ).withValues(alpha: 0.80),
      AnswerOptionStatus.selected => QuizPalette.selectedBorder(context),
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
    };
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
          color: QuizPalette.transparent,
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
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      color: badgeBackgroundColor,
                      border: Border.all(color: badgeBorderColor),
                    ),

                    child: SizedBox(
                      width: QuizDimensions.optionBadgeSize,
                      height: QuizDimensions.optionBadgeSize,
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
                        color: answerTextColor,
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
