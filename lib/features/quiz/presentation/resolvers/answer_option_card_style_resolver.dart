import 'package:flutter/material.dart';

import '../constants/quiz_dimensions.dart';
import '../models/answer_option_card_style.dart';
import '../models/answer_option_status.dart';
import '../theme/quiz_palette.dart';

AnswerOptionCardStyle resolveAnswerOptionCardStyle({
  required BuildContext context,
  required AnswerOptionStatus status,
}) {
  return AnswerOptionCardStyle(
    backgroundColor: switch (status) {
      AnswerOptionStatus.idle => QuizPalette.optionFill(context),
      AnswerOptionStatus.selected => QuizPalette.selectedFill(context),
      AnswerOptionStatus.correct => QuizPalette.correctFill(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongFill(context),
    },
    borderColor: switch (status) {
      AnswerOptionStatus.idle => QuizPalette.optionBorder(context),
      AnswerOptionStatus.selected => QuizPalette.selectedBorder(context),
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
    },
    badgeBackgroundColor: switch (status) {
      AnswerOptionStatus.idle => QuizPalette.secondaryText(
        context,
      ).withValues(alpha: QuizDimensions.optionBadgeIdleFillAlpha),
      AnswerOptionStatus.selected => QuizPalette.selectedFill(context),
      AnswerOptionStatus.correct => QuizPalette.correctFill(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongFill(context),
    },
    badgeBorderColor: switch (status) {
      AnswerOptionStatus.idle => QuizPalette.secondaryText(
        context,
      ).withValues(alpha: QuizDimensions.optionBadgeIdleBorderAlpha),
      AnswerOptionStatus.selected => QuizPalette.selectedBorder(context),
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
    },
    answerTextColor: switch (status) {
      AnswerOptionStatus.idle => QuizPalette.primaryText(context),
      AnswerOptionStatus.selected => QuizPalette.primaryText(context),
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
    },
    shouldLift: status == AnswerOptionStatus.selected,
    trailingIcon: switch (status) {
      AnswerOptionStatus.correct => Icons.check_circle_rounded,
      AnswerOptionStatus.wrong => Icons.cancel_rounded,
      _ => null,
    },
    trailingIconColor: switch (status) {
      AnswerOptionStatus.correct => QuizPalette.correctBorder(context),
      AnswerOptionStatus.wrong => QuizPalette.wrongBorder(context),
      _ => null,
    },
  );
}
