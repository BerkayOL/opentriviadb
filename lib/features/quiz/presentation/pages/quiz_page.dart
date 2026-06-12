import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/app_routes.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/answer_option_card.dart';
import '../widgets/quiz_progress_header.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: SafeArea(
        child: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            switch (state.status) {
              case QuizStatus.initial:
              case QuizStatus.loading:
                return const _LoadingView();
              case QuizStatus.failure:
                return const Center(child: Text('Failed to load questions.'));
              case QuizStatus.empty:
                return const Center(child: Text('No questions available.'));
              case QuizStatus.inProgress:
                return _QuestionView(state: state);
              case QuizStatus.completed:
                return _CompletedView(state: state);
              case QuizStatus.answerRevealed:
                return _QuestionView(state: state);
            }
          },
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  final String loadingMessage = 'Loading questions...';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppSpacing.md),
          Text(loadingMessage, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    final question = state.currentQuestion;
    if (question == null) {
      return const Center(child: Text('No question available.'));
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
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            question.question,
            style: Theme.of(context).textTheme.titleLarge,
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
              label: state.isLastQuestion ? 'See Results' : 'Next Question',
              icon: Icons.arrow_forward_rounded,
              onPressed: () => context.read<QuizCubit>().nextQuestion(),
            ),
        ],
      ),
    );
  }
}

class _CompletedView extends StatelessWidget {
  const _CompletedView({required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quiz Completed!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'You scored ${state.score} out of ${state.totalQuestions}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          AppButton(
            label: 'Restart Quiz',
            icon: Icons.restart_alt_rounded,
            onPressed: () => context.go(AppRoutes.setup),
          ),
        ],
      ),
    );
  }
}
