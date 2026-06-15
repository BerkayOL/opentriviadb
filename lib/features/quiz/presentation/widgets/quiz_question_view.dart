import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/quiz/presentation/widgets/quiz_question_card.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import 'answer_option_card.dart';
import 'answer_option_status_resolver.dart';
import 'quiz_progress_header.dart';
import 'quiz_timer_badge.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({required this.state, super.key});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final question = state.currentQuestion;

    if (question == null) {
      return const Center(child: Text(AppStrings.noQuestionAvailable));
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QuizProgressHeader(
                  currentQuestion: state.currentIndex + 1,
                  totalQuestions: state.totalQuestions,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              QuizTimerBadge(secondsLeft: state.secondsLeft),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          QuizQuestionCard(question: question.question),
          const SizedBox(height: AppSpacing.md),
          ...question.answers.map((answer) {
            final optionStatus = resolveAnswerStatus(
              state: state,
              answer: answer,
              correctAnswer: question.correctAnswer,
            );

            return AnswerOptionCard(
              answer: answer,
              status: optionStatus,
              onTap: () {
                if (state.status == QuizStatus.answerRevealed) {
                  return;
                }

                context.read<QuizCubit>().selectAnswer(answer);
              },
            );
          }),
          const Spacer(),
          if (state.status == QuizStatus.answerRevealed)
            AppButton(
              label: state.isLastQuestion
                  ? AppStrings.seeResults
                  : AppStrings.nextQuestion,
              icon: Icons.arrow_forward_rounded,
              onPressed: () {
                context.read<QuizCubit>().nextQuestion();
              },
            ),
        ],
      ),
    );
  }
}
