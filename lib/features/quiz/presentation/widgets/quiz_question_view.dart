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
import 'quiz_progress_bar.dart';

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
          const SizedBox(height: AppSpacing.md),
          QuizProgressBar(
            currentQuestion: state.currentIndex + 1,
            totalQuestions: state.totalQuestions,
          ),
          const SizedBox(height: AppSpacing.lg),
          AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              transitionBuilder: (child, animation) {
                final slideAnimation =
                    Tween<Offset>(
                      begin: const Offset(0.03, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    );

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: child,
                  ),
                );
              },
              child: Column(
                key: ValueKey(state.currentIndex),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuizQuestionCard(question: question.question),
                  const SizedBox(height: AppSpacing.md),
                  ...question.answers.asMap().entries.map((entry) {
                    final optionIndex = entry.key;
                    final answer = entry.value;

                    final optionStatus = resolveAnswerStatus(
                      state: state,
                      answer: answer,
                      correctAnswer: question.correctAnswer,
                    );

                    return AnswerOptionCard(
                      answer: answer,
                      optionIndex: optionIndex,
                      status: optionStatus,
                      onTap: () {
                        if (state.status == QuizStatus.answerRevealed) {
                          return;
                        }

                        context.read<QuizCubit>().selectAnswer(answer);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
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
