import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/quiz_request.dart';
import '../theme/quiz_setup_palette.dart';
import '../widgets/setup/quiz_setup_card.dart';
import '../widgets/setup/quiz_setup_header.dart';

class QuizSetupPage extends StatelessWidget {
  const QuizSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: QuizSetupPalette.backgroundGradient(context),
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              const SetupHeader(),
              const SizedBox(height: AppSpacing.xl),
              SetupCard(
                onStartQuiz: (QuizRequest request) {
                  context.push(AppRoutes.quiz, extra: request);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
