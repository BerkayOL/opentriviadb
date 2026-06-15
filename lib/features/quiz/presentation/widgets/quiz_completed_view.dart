import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../cubits/quiz_state.dart';

class CompletedView extends StatelessWidget {
  const CompletedView({super.key, required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.quizCompleted,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppStrings.quizScoreResult(state.score, state.totalQuestions),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          AppButton(
            label: AppStrings.restartQuiz,
            icon: Icons.restart_alt_rounded,
            onPressed: () => context.go(AppRoutes.setup),
          ),
        ],
      ),
    );
  }
}
