import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../widgets/setup/quiz_setup_card.dart';
import '../widgets/setup/quiz_setup_header.dart';

class QuizSetupPage extends StatelessWidget {
  const QuizSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF08111F), Color(0xFF111827), Color(0xFF172554)],
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
