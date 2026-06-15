import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import '../theme/quiz_palette.dart';
import 'answer_option_card.dart';
import 'quiz_progress_header.dart';
import 'quiz_timer_badge.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({super.key, required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuizProgressHeader(
                currentQuestion: state.currentIndex + 1,
                totalQuestions: state.totalQuestions,
              ),
              QuizTimerBadge(secondsLeft: state.secondsLeft),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            color: QuizPalette.cardColor(context),
            borderColor: QuizPalette.cardBorder(context),
            borderRadius: 30,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              question.question,
              style: textTheme.titleLarge?.copyWith(
                color: QuizPalette.primaryText(context),
                fontWeight: FontWeight.w800,
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...question.answers.map((answer) {
            final isSelected = answer == state.selectedAnswer;
            final isCorrect = answer == question.correctAnswer;
            Color? cardColor;
            if (state.status == QuizStatus.answerRevealed) {
              if (isSelected) {
                cardColor = isCorrect ? Colors.green[100] : Colors.red[100];
              } else if (isCorrect) {
                cardColor = Colors.green[100];
              }
            }
            return AnswerOptionCard(
              selected: isSelected,
              answer: answer,

              onTap: () {
                if (state.status == QuizStatus.answerRevealed) {
                  return;
                }
                context.read<QuizCubit>().selectAnswer(answer);
              },
              color: cardColor,
            );
          }),
          const Spacer(),
          if (state.status == QuizStatus.answerRevealed)
            AppButton(
              label: state.isLastQuestion
                  ? AppStrings.seeResults
                  : AppStrings.nextQuestion,
              icon: Icons.arrow_forward_rounded,
              onPressed: () => context.read<QuizCubit>().nextQuestion(),
            ),
        ],
      ),
    );
  }
}
