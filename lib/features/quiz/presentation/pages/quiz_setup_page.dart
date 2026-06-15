import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/setup/quiz_setup_card.dart';
import '../widgets/setup/quiz_setup_header.dart';
import '../widgets/setup/quiz_setup_palette.dart';

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
            children: const [
              SetupHeader(),
              SizedBox(height: AppSpacing.xl),
              SetupCard(),
            ],
          ),
        ),
      ),
    );
  }
}
