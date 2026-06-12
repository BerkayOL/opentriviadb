import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/setup_option_card.dart';

class QuizSetupPage extends StatelessWidget {
  const QuizSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            tooltip: 'History',
            onPressed: () => context.push(AppRoutes.history),
            icon: const Icon(Icons.history_outlined),
          ),
          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              'Trivia Quiz',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              AppStrings.setupSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            const SetupOptionCard(title: 'Category', value: 'Any category'),
            const SizedBox(height: AppSpacing.md),
            const SetupOptionCard(title: 'Difficulty', value: 'Any level'),
            const SizedBox(height: AppSpacing.md),
            const SetupOptionCard(title: 'Questions', value: '10'),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Start Quiz',
              icon: Icons.play_arrow_rounded,
              onPressed: () => context.push(AppRoutes.quiz),
            ),
          ],
        ),
      ),
    );
  }
}
