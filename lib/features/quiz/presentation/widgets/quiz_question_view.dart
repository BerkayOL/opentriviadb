import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/quiz_palette.dart';
import 'boolean_answer_feedback.dart';
import 'boolean_answer_switch.dart';
import 'quiz_action_button.dart';
import 'quiz_question_card.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/constants/quiz_api_values.dart';
import '../constants/quiz_dimensions.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import 'answer_option_card.dart';
import '../resolvers/answer_option_status_resolver.dart';
import 'quiz_progress_header.dart';
import 'quiz_timer_badge.dart';
import 'quiz_progress_bar.dart';
import '../dialogs/show_exit_quiz_dialog.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({required this.state, super.key});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final question = state.currentQuestion;

    if (question == null) {
      return const Center(child: Text(AppStrings.noQuestionAvailable));
    }
    final isBooleanQuestion = question.type == QuizApiValues.boolean;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: QuizDimensions.backButtonSize,
                height: QuizDimensions.backButtonSize,
                child: Material(
                  color: QuizPalette.primaryText(
                    context,
                  ).withValues(alpha: QuizDimensions.backButtonFillAlpha),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: InkWell(
                    onTap: () => showExitQuizDialog(context),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(
                          color: QuizPalette.primaryText(context).withValues(
                            alpha: QuizDimensions.backButtonBorderAlpha,
                          ),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: QuizPalette.primaryText(context),
                        size: QuizDimensions.backButtonIconSize,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
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
                  if (isBooleanQuestion)
                    Column(
                      children: [
                        BooleanAnswerSwitch(
                          falseStatus: resolveAnswerStatus(
                            state: state,
                            answer: AppStrings.falseAnswer,
                            correctAnswer: question.correctAnswer,
                          ),
                          trueStatus: resolveAnswerStatus(
                            state: state,
                            answer: AppStrings.trueAnswer,
                            correctAnswer: question.correctAnswer,
                          ),
                          onFalseTap: () {
                            if (state.status == QuizStatus.answerRevealed) {
                              return;
                            }

                            context.read<QuizCubit>().selectAnswer(
                              AppStrings.falseAnswer,
                            );
                          },
                          onTrueTap: () {
                            if (state.status == QuizStatus.answerRevealed) {
                              return;
                            }

                            context.read<QuizCubit>().selectAnswer(
                              AppStrings.trueAnswer,
                            );
                          },
                        ),
                        BooleanAnswerFeedback(state: state),
                      ],
                    )
                  else
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
