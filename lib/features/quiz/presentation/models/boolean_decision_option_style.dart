import 'package:flutter/material.dart';

class BooleanDecisionOptionStyle {
  const BooleanDecisionOptionStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.accentColor,
    required this.labelColor,
    required this.supportColor,
    required this.iconFillColor,
    required this.helperText,
    required this.shouldLift,
    this.trailingIcon,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color accentColor;
  final Color labelColor;
  final Color supportColor;
  final Color iconFillColor;
  final String helperText;
  final bool shouldLift;
  final IconData? trailingIcon;
}
