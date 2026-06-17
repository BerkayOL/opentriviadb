import 'package:flutter/material.dart';

import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/quiz_dimensions.dart';
import '../models/answer_option_status.dart';
import '../resolvers/boolean_decision_option_style_resolver.dart';
import '../theme/quiz_palette.dart';
import 'boolean_decision_option_helper.dart';
import 'boolean_decision_option_icon_badge.dart';

class BooleanDecisionOption extends StatelessWidget {
  const BooleanDecisionOption({
    super.key,
    required this.label,
    required this.icon,
    required this.status,
    required this.semanticLabel,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final AnswerOptionStatus status;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final optionStyle = resolveBooleanDecisionOptionStyle(
      context: context,
      status: status,
    );
    final isIdle = status == AnswerOptionStatus.idle;
    final isActive = !isIdle;

    return Semantics(
      button: true,
      selected: status != AnswerOptionStatus.idle,
      label: semanticLabel,
      child: AnimatedScale(
        scale: optionStyle.shouldLift
            ? QuizDimensions.optionSelectedScale
            : QuizDimensions.optionIdleScale,
        duration: AppMotion.fast,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: AppMotion.normal,
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: optionStyle.backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: isIdle
                  ? QuizPalette.optionBorder(
                      context,
                    ).withValues(alpha: QuizDimensions.booleanIdleBorderAlpha)
                  : optionStyle.borderColor,
              width: isIdle
                  ? QuizDimensions.booleanIdleBorderWidth
                  : QuizDimensions.booleanActiveBorderWidth,
            ),
            boxShadow: [
              BoxShadow(
                color: QuizPalette.booleanOptionShadow(context),
                blurRadius: isActive
                    ? QuizDimensions.booleanActiveShadowBlur
                    : QuizDimensions.booleanIdleShadowBlur,
                offset: const Offset(
                  0,
                  QuizDimensions.booleanOptionShadowOffsetY,
                ),
              ),
            ],
          ),
          child: Material(
            color: QuizPalette.transparent,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BooleanDecisionOptionIconBadge(
                      icon: icon,
                      accentColor: optionStyle.accentColor,
                      fillColor: optionStyle.iconFillColor,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          label,
                          maxLines: 1,
                          style: textTheme.titleLarge?.copyWith(
                            color: optionStyle.labelColor,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    BooleanDecisionOptionHelper(
                      helperText: optionStyle.helperText,
                      supportColor: optionStyle.supportColor,
                      accentColor: optionStyle.accentColor,
                      trailingIcon: optionStyle.trailingIcon,
                    ),
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
