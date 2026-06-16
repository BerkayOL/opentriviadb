import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/quiz_palette.dart';
import 'boolean_answer_switch.dart';
import 'quiz_action_button.dart';
import 'quiz_question_card.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import 'answer_option_card.dart';
import 'answer_option_status_resolver.dart';
import 'quiz_progress_header.dart';
import 'quiz_timer_badge.dart';
import 'quiz_progress_bar.dart';
import 'show_exit_quiz_dialog.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({required this.state, super.key});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final question = state.currentQuestion;

    if (question == null) {
      return const Center(child: Text(AppStrings.noQuestionAvailable));
    }
    final isBooleanQuestion = question.type == 'boolean';

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: Material(
                  color: QuizPalette.primaryText(
                    context,
                  ).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () => showExitQuizDialog(context),
                    borderRadius: BorderRadius.circular(16),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: QuizPalette.primaryText(
                            context,
                          ).withValues(alpha: 0.14),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: QuizPalette.primaryText(context),
                        size: 24,
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
                  children: [...previousChildren, ?currentChild],
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
                  if (isBooleanQuestion)
                    Column(
                      children: [
                        BooleanAnswerSwitch(
                          falseStatus: resolveAnswerStatus(
                            state: state,
                            answer: 'False',
                            correctAnswer: question.correctAnswer,
                          ),
                          trueStatus: resolveAnswerStatus(
                            state: state,
                            answer: 'True',
                            correctAnswer: question.correctAnswer,
                          ),
                          onFalseTap: () {
                            if (state.status == QuizStatus.answerRevealed) {
                              return;
                            }

                            context.read<QuizCubit>().selectAnswer('False');
                          },
                          onTrueTap: () {
                            if (state.status == QuizStatus.answerRevealed) {
                              return;
                            }

                            context.read<QuizCubit>().selectAnswer('True');
                          },
                        ),
                        _BooleanAnswerFeedback(state: state),
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

class _BooleanAnswerFeedback extends StatelessWidget {
  const _BooleanAnswerFeedback({required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final isRevealed = state.status == QuizStatus.answerRevealed;
    final isTimeout = isRevealed && state.selectedAnswer == null;
    final isCorrect = state.isAnswerCorrect == true;
    final color = isCorrect
        ? QuizPalette.correctBorder(context)
        : QuizPalette.wrongBorder(context);
    final title = isTimeout
        ? AppStrings.answerTimeoutTitle
        : isCorrect
        ? AppStrings.answerCorrectTitle
        : AppStrings.answerWrongTitle;
    final message = isTimeout
        ? AppStrings.answerTimeoutMessage
        : isCorrect
        ? AppStrings.answerCorrectMessage
        : AppStrings.answerWrongMessage;
    final icon = isCorrect
        ? Icons.check_circle_rounded
        : isTimeout
        ? Icons.timer_off_rounded
        : Icons.cancel_rounded;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: isRevealed
          ? Container(
              key: ValueKey(title),
              margin: const EdgeInsets.only(top: AppSpacing.sm),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: QuizPalette.isDark(context) ? 0.15 : 0.10,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withValues(alpha: 0.42)),
              ),
              child: Row(
                children: [
                  Icon(icon, color: color, size: 24),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: color,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          message,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: QuizPalette.primaryText(
                                  context,
                                ).withValues(alpha: 0.82),
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
