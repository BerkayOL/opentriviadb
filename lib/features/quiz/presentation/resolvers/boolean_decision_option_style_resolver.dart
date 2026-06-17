import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../constants/quiz_dimensions.dart';
import '../models/answer_option_status.dart';
import '../models/boolean_decision_option_style.dart';
import '../theme/quiz_palette.dart';

BooleanDecisionOptionStyle resolveBooleanDecisionOptionStyle({
  required BuildContext context,
  required AnswerOptionStatus status,
}) {
  final neutralColor = QuizPalette.secondaryText(context);
  final accentColor = switch (status) {
    AnswerOptionStatus.idle => neutralColor,
    AnswerOptionStatus.selected => QuizPalette.accent(context),
    AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
    AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
  };
  final labelColor = switch (status) {
    AnswerOptionStatus.idle => QuizPalette.primaryText(context),
    AnswerOptionStatus.selected => QuizPalette.primaryText(context),
    AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
    AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
  };

  return BooleanDecisionOptionStyle(
    backgroundColor: switch (status) {
      AnswerOptionStatus.idle => QuizPalette.optionFill(context),
      AnswerOptionStatus.selected => QuizPalette.selectedFill(context),
      AnswerOptionStatus.correct => QuizPalette.correctFill(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context).withValues(
        alpha: QuizPalette.isDark(context)
            ? QuizDimensions.booleanWrongFillDarkAlpha
            : QuizDimensions.booleanWrongFillLightAlpha,
      ),
    },
    borderColor: switch (status) {
      AnswerOptionStatus.idle => QuizPalette.optionBorder(context),
      AnswerOptionStatus.selected => QuizPalette.selectedBorder(context),
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context).withValues(
        alpha: QuizPalette.isDark(context)
            ? QuizDimensions.booleanWrongBorderDarkAlpha
            : QuizDimensions.booleanWrongBorderLightAlpha,
      ),
    },
    accentColor: accentColor,
    labelColor: labelColor,
    supportColor: status == AnswerOptionStatus.idle
        ? QuizPalette.secondaryText(context)
        : labelColor,
    iconFillColor: status == AnswerOptionStatus.idle
        ? QuizPalette.cardColor(context)
        : accentColor.withValues(
            alpha: QuizDimensions.booleanIdleIconFillAlpha,
          ),
    helperText: switch (status) {
      AnswerOptionStatus.idle => AppStrings.tapToChoose,
      AnswerOptionStatus.selected => AppStrings.yourChoice,
      AnswerOptionStatus.correct => AppStrings.correctAnswer,
      AnswerOptionStatus.wrong => AppStrings.yourChoice,
    },
    shouldLift: status != AnswerOptionStatus.idle,
    trailingIcon: switch (status) {
      AnswerOptionStatus.correct => Icons.check_circle_rounded,
      AnswerOptionStatus.wrong => Icons.cancel_rounded,
      _ => null,
    },
  );
}
