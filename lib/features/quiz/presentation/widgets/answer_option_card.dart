import 'package:flutter/material.dart';

import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/quiz_dimensions.dart';
import '../models/answer_option_status.dart';
import '../resolvers/answer_option_card_style_resolver.dart';
import '../theme/quiz_palette.dart';
import 'answer_option_badge.dart';

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
    final cardStyle = resolveAnswerOptionCardStyle(
      context: context,
      status: status,
    );

    return AnimatedScale(
      scale: cardStyle.shouldLift
          ? QuizDimensions.optionSelectedScale
          : QuizDimensions.optionIdleScale,
      duration: AppMotion.fast,
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        duration: AppMotion.medium,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: cardStyle.backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: cardStyle.borderColor),
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
                  AnswerOptionBadge(
                    optionIndex: optionIndex,
                    backgroundColor: cardStyle.badgeBackgroundColor,
                    borderColor: cardStyle.badgeBorderColor,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      answer,
                      style: textTheme.bodyLarge?.copyWith(
                        color: cardStyle.answerTextColor,
                        fontWeight: FontWeight.w700,
                        height: QuizDimensions.answerTextHeight,
                      ),
                    ),
                  ),
                  if (cardStyle.trailingIcon != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Icon(
                      cardStyle.trailingIcon,
                      color: cardStyle.trailingIconColor,
                      size: QuizDimensions.answerTrailingIconSize,
                    ),
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
