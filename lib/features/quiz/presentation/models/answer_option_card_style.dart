import 'package:flutter/material.dart';

class AnswerOptionCardStyle {
  const AnswerOptionCardStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.badgeBackgroundColor,
    required this.badgeBorderColor,
    required this.answerTextColor,
    required this.shouldLift,
    this.trailingIcon,
    this.trailingIconColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color badgeBackgroundColor;
  final Color badgeBorderColor;
  final Color answerTextColor;
  final bool shouldLift;
  final IconData? trailingIcon;
  final Color? trailingIconColor;
}
