import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quiz Result',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(AppStrings.comingSoon),
              const Spacer(),
              AppButton(
                label: 'New Quiz',
                icon: Icons.refresh_rounded,
                onPressed: () => context.go(AppRoutes.setup),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
