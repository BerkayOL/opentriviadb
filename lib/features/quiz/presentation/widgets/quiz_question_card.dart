import 'package:flutter/material.dart';
import 'package:opentriviadb/core/widgets/app_card.dart';
import 'package:opentriviadb/features/quiz/presentation/theme/quiz_palette.dart';

class QuizQuestionCard extends StatelessWidget {
  const QuizQuestionCard({required this.question, super.key});
  final String question;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Text(
        question,
        style: textTheme.titleLarge?.copyWith(
          color: QuizPalette.primaryText(context),
          fontWeight: FontWeight.w800,
          height: 1.35,
        ),
      ),
    );
  }
}
