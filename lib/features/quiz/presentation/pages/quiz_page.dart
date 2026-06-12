import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/answer_option_card.dart';
import '../widgets/quiz_progress_header.dart';
import '../widgets/quiz_timer_badge.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuizProgressHeader(currentQuestion: 1, totalQuestions: 10),
                  QuizTimerBadge(secondsLeft: 30),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                AppStrings.comingSoon,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              AnswerOptionCard(
                answer: 'Answer option placeholder',
                onTap: () {},
              ),
              const Spacer(),
              AppButton(
                label: 'Show Result',
                icon: Icons.flag_outlined,
                onPressed: () => context.go(AppRoutes.result),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
