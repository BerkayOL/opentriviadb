import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_motion.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../constants/quiz_dimensions.dart';
import '../../models/answer_option_status.dart';
import '../../theme/quiz_palette.dart';
import 'boolean_decision_option.dart';

class BooleanAnswerSwitch extends StatelessWidget {
  const BooleanAnswerSwitch({
    required this.falseStatus,
    required this.trueStatus,
    required this.onFalseTap,
    required this.onTrueTap,
    super.key,
  });

  final AnswerOptionStatus falseStatus;
  final AnswerOptionStatus trueStatus;
  final VoidCallback onFalseTap;
  final VoidCallback onTrueTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppRadius.xxl);

    return Semantics(
      label: AppStrings.trueFalseAnswerChoices,
      child: AnimatedContainer(
        height: QuizDimensions.booleanSwitchHeight,
        duration: AppMotion.normal,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: QuizPalette.cardColor(context),
          borderRadius: borderRadius,
          border: Border.all(color: QuizPalette.cardBorder(context)),
          boxShadow: [
            BoxShadow(
              color: QuizPalette.booleanSwitchShadow(context),
              blurRadius: QuizDimensions.booleanSwitchShadowBlur,
              offset: const Offset(
                0,
                QuizDimensions.booleanSwitchShadowOffsetY,
              ),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Row(
            children: [
              Expanded(
                child: BooleanDecisionOption(
                  label: AppStrings.falseAnswer,
                  icon: Icons.close_rounded,
                  status: falseStatus,
                  semanticLabel: AppStrings.falseAnswerOption,
                  onTap: onFalseTap,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: BooleanDecisionOption(
                  label: AppStrings.trueAnswer,
                  icon: Icons.check_rounded,
                  status: trueStatus,
                  semanticLabel: AppStrings.trueAnswerOption,
                  onTap: onTrueTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
