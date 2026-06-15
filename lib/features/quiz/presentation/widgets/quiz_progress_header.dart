import 'package:flutter/material.dart';
import 'package:opentriviadb/features/quiz/presentation/theme/quiz_palette.dart';

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
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: QuizPalette.primaryText(context),
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
      ),
    );
  }
}
