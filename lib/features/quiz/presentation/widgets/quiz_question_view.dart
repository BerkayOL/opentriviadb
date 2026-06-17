import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'quiz_action_button.dart';
import 'quiz_question_card.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../constants/quiz_dimensions.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import 'quiz_answer_section.dart';
import 'quiz_question_header.dart';

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
          QuizQuestionHeader(
            currentQuestion: state.currentIndex + 1,
            totalQuestions: state.totalQuestions,
            secondsLeft: state.secondsLeft,
          ),
          const SizedBox(height: AppSpacing.lg),
          AnimatedSize(
            duration: AppMotion.medium,
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: AppMotion.medium,
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [...previousChildren, ?currentChild],
                );
              },
              transitionBuilder: (child, animation) {
                final slideAnimation =
                    Tween<Offset>(
                      begin: const Offset(
                        QuizDimensions.progressAnimationSlideX,
                        0,
                      ),
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
                  QuizAnswerSection(question: question, state: state),
                ],
              ),
            ),
          ),
          const Spacer(),
          if (state.status == QuizStatus.answerRevealed)
            QuizActionButton(
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
