import 'package:flutter/material.dart';

import '../../../../core/widgets/app_card.dart';

class AnswerOptionCard extends StatelessWidget {
  const AnswerOptionCard({
    required this.answer,
    required this.onTap,
    super.key,
    Color? color,
  });

  final String answer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AppCard(child: Text(answer)),
    );
  }
}
