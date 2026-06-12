import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/quiz_category.dart';
import '../cubits/quiz_setup_cubit.dart';
import '../cubits/quiz_setup_state.dart';
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
            const _CategorySelector(),
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

class _CategorySelector extends StatelessWidget {
  const _CategorySelector();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSetupCubit, QuizSetupState>(
      builder: (context, state) {
        return switch (state.status) {
          QuizSetupStatus.initial || QuizSetupStatus.loading => const SizedBox(
            height: 96,
            child: LoadingView(),
          ),
          QuizSetupStatus.failure => ErrorView(
            message: state.errorMessage ?? 'Categories could not be loaded.',
            onRetry: context.read<QuizSetupCubit>().loadCategories,
          ),
          QuizSetupStatus.ready =>
            state.categories.isEmpty
                ? const EmptyView(
                    title: 'No categories found',
                    message: 'Try again later or start with any category.',
                  )
                : DropdownButtonFormField<QuizCategory>(
                    initialValue: state.selectedCategory,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: state.categories
                        .map(
                          (category) => DropdownMenuItem<QuizCategory>(
                            value: category,
                            child: Text(category.name),
                          ),
                        )
                        .toList(),
                    onChanged: context.read<QuizSetupCubit>().selectCategory,
                  ),
        };
      },
    );
  }
}
