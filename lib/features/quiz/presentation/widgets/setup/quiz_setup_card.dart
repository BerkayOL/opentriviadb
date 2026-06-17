import 'package:flutter/material.dart';
import 'package:opentriviadb/features/quiz/presentation/theme/quiz_setup_palette.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'difficulty_selector.dart';
import 'question_count_selector.dart';
import 'question_type_selector.dart';
import 'quiz_category_selector.dart';
import 'quiz_start_button.dart';
import 'setup_field_section.dart';

class SetupCard extends StatelessWidget {
  const SetupCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: QuizSetupPalette.cardColor(context),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: BorderSide(color: QuizSetupPalette.cardBorder(context)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SetupFieldSection(
              icon: Icons.category_rounded,
              title: AppStrings.category,
              child: CategorySelector(),
            ),
            SizedBox(height: AppSpacing.lg),
            SetupFieldSection(
              icon: Icons.speed_rounded,
              title: AppStrings.difficulty,
              child: DifficultySelector(),
            ),
            SizedBox(height: AppSpacing.lg),
            SetupFieldSection(
              icon: Icons.format_list_numbered_rounded,
              title: AppStrings.numberOfQuestions,
              child: QuestionCountSelector(),
            ),
            SizedBox(height: AppSpacing.lg),
            SetupFieldSection(
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
