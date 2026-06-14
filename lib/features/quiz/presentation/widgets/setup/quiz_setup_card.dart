import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'difficulty_selector.dart';
import 'question_count_selector.dart';
import 'question_type_selector.dart';
import 'quiz_category_selector.dart';
import 'quiz_start_button.dart';

class SetupCard extends StatelessWidget {
  const SetupCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _SetupFieldSection(
              icon: Icons.category_rounded,
              title: AppStrings.category,
              child: CategorySelector(),
            ),
            SizedBox(height: AppSpacing.lg),
            _SetupFieldSection(
              icon: Icons.speed_rounded,
              title: AppStrings.difficulty,
              child: DifficultySelector(),
            ),
            SizedBox(height: AppSpacing.lg),
            _SetupFieldSection(
              icon: Icons.format_list_numbered_rounded,
              title: AppStrings.numberOfQuestions,
              child: QuestionCountSelector(),
            ),
            SizedBox(height: AppSpacing.lg),
            _SetupFieldSection(
              icon: Icons.tune_rounded,
              title: AppStrings.questionType,
              child: QuestionTypeSelector(),
            ),
            SizedBox(height: AppSpacing.xl),
            StartQuizButton(),
          ],
        ),
      ),
    );
  }
}

class _SetupFieldSection extends StatelessWidget {
  const _SetupFieldSection({
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.82),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        child,
      ],
    );
  }
}
