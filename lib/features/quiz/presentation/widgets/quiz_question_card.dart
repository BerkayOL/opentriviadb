import 'package:flutter/material.dart';
import 'package:opentriviadb/core/theme/app_spacing.dart';
import 'package:opentriviadb/core/widgets/app_card.dart';
import 'package:opentriviadb/features/quiz/presentation/theme/quiz_palette.dart';

class QuizQuestionCard extends StatelessWidget {
  const QuizQuestionCard({required this.question, super.key});
  final String question;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      color: QuizPalette.cardColor(context),
      borderColor: QuizPalette.cardBorder(
        context,
      ).withValues(alpha: QuizPalette.isDark(context) ? 0.45 : 0.62),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Text(
        question,
        style: textTheme.titleLarge?.copyWith(
          color: QuizPalette.primaryText(context),
          fontWeight: FontWeight.w700,
          height: 1.18,
        ),
      ),
    );
  }
}
