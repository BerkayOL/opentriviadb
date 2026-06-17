import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/quiz_dimensions.dart';
import '../models/answer_option_status.dart';
import '../theme/quiz_palette.dart';

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
                child: _BooleanDecisionOption(
                  label: AppStrings.falseAnswer,
                  icon: Icons.close_rounded,
                  status: falseStatus,
                  semanticLabel: AppStrings.falseAnswerOption,
                  onTap: onFalseTap,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _BooleanDecisionOption(
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

class _BooleanDecisionOption extends StatelessWidget {
  const _BooleanDecisionOption({
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
    final neutralColor = QuizPalette.secondaryText(context);

    final backgroundColor = switch (status) {
      AnswerOptionStatus.idle => QuizPalette.optionFill(context),
      AnswerOptionStatus.selected => QuizPalette.selectedFill(context),
      AnswerOptionStatus.correct => QuizPalette.correctFill(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context).withValues(
        alpha: QuizPalette.isDark(context)
            ? QuizDimensions.booleanWrongFillDarkAlpha
            : QuizDimensions.booleanWrongFillLightAlpha,
      ),
    };
    final isIdle = status == AnswerOptionStatus.idle;
    final isActive = !isIdle;
    final accentColor = switch (status) {
      AnswerOptionStatus.idle => neutralColor,
      AnswerOptionStatus.selected => QuizPalette.accent(context),
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
    };

    final borderColor = switch (status) {
      AnswerOptionStatus.idle => QuizPalette.optionBorder(context),
      AnswerOptionStatus.selected => QuizPalette.selectedBorder(context),
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context).withValues(
        alpha: QuizPalette.isDark(context)
            ? QuizDimensions.booleanWrongBorderDarkAlpha
            : QuizDimensions.booleanWrongBorderLightAlpha,
      ),
    };

    final labelColor = switch (status) {
      AnswerOptionStatus.idle => QuizPalette.primaryText(context),
      AnswerOptionStatus.selected => QuizPalette.primaryText(context),
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
    };
    final supportColor = status == AnswerOptionStatus.idle
        ? QuizPalette.secondaryText(context)
        : labelColor;
    final iconFillColor = status == AnswerOptionStatus.idle
        ? QuizPalette.cardColor(context)
        : accentColor.withValues(
            alpha: QuizDimensions.booleanIdleIconFillAlpha,
          );
    final trailingIcon = switch (status) {
      AnswerOptionStatus.correct => Icons.check_circle_rounded,
      AnswerOptionStatus.wrong => Icons.cancel_rounded,
      _ => null,
    };
    final helperText = switch (status) {
      AnswerOptionStatus.idle => AppStrings.tapToChoose,
      AnswerOptionStatus.selected => AppStrings.yourChoice,
      AnswerOptionStatus.correct => AppStrings.correctAnswer,
      AnswerOptionStatus.wrong => AppStrings.yourChoice,
    };
    final shouldLift =
        status == AnswerOptionStatus.selected ||
        status == AnswerOptionStatus.correct ||
        status == AnswerOptionStatus.wrong;

    return Semantics(
      button: true,
      selected: status != AnswerOptionStatus.idle,
      label: semanticLabel,
      child: AnimatedScale(
        scale: shouldLift
            ? QuizDimensions.optionSelectedScale
            : QuizDimensions.optionIdleScale,
        duration: AppMotion.fast,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: AppMotion.normal,
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: isIdle
                  ? QuizPalette.optionBorder(
                      context,
                    ).withValues(alpha: QuizDimensions.booleanIdleBorderAlpha)
                  : borderColor,
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
                    AnimatedContainer(
                      width: QuizDimensions.booleanIconBadgeSize,
                      height: QuizDimensions.booleanIconBadgeSize,
                      duration: AppMotion.normal,
                      curve: Curves.easeOutCubic,
                      decoration: BoxDecoration(
                        color: iconFillColor,
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
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          label,
                          maxLines: 1,
                          style: textTheme.titleLarge?.copyWith(
                            color: labelColor,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
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
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ],
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
