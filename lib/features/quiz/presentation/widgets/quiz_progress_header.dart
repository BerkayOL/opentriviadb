import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';

class QuizProgressHeader extends StatelessWidget {
  const QuizProgressHeader({
    required this.currentQuestion,
    required this.totalQuestions,
    super.key,
  });

  final int currentQuestion;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.questionProgress(currentQuestion, totalQuestions),
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
