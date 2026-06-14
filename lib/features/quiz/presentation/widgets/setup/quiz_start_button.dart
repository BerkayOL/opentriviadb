import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../domain/entities/quiz_request.dart';
import '../../cubits/quiz_setup_cubit.dart';
import '../../cubits/quiz_setup_state.dart';

class StartQuizButton extends StatelessWidget {
  const StartQuizButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSetupCubit, QuizSetupState>(
      builder: (context, state) {
        final isReady = state.status == QuizSetupStatus.ready;
        return Opacity(
          opacity: isReady ? 1 : 0.55,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF3B82F6),
                  Color(0xFF6366F1),
                  Color(0xFF8B5CF6),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                  color: const Color(0xFF6366F1).withValues(alpha: 0.24),
                ),
              ],
            ),
            child: FilledButton.icon(
              onPressed: isReady
                  ? () {
                      final request = QuizRequest(
                        amount: state.questionCount,
                        categoryId: state.selectedCategory?.id,
                        difficulty: state.selectedDifficulty,
                        type: state.questionType,
                      );
                      context.push(AppRoutes.quiz, extra: request);
                    }
                  : null,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text(AppStrings.startQuiz),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(58),
                backgroundColor: Colors.transparent,
                disabledBackgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
