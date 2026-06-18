import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import 'quiz_completed_view.dart';
import 'quiz_loading_view.dart';
import 'quiz_question_view.dart';

class QuizStateView extends StatelessWidget {
  const QuizStateView({
    required this.state,
    required this.onExitRequested,
    required this.onPlayAgain,
    super.key,
  });

  final QuizState state;
  final VoidCallback onExitRequested;
  final VoidCallback onPlayAgain;

  @override
  Widget build(BuildContext context) {
    return switch (state.status) {
      QuizStatus.initial || QuizStatus.loading => const QuizLoadingView(),
      QuizStatus.failure => ErrorView(
        message: state.errorMessage ?? AppStrings.genericError,
        onRetry: context.read<QuizCubit>().retryQuiz,
      ),
      QuizStatus.empty => const EmptyView(
        title: AppStrings.noQuestionsTitle,
        message: AppStrings.noQuestionsMessage,
      ),
      QuizStatus.inProgress || QuizStatus.answerRevealed => QuestionView(
        state: state,
        onExitRequested: onExitRequested,
      ),
      QuizStatus.completed => QuizCompletedView(
        state: state,
        onPlayAgain: onPlayAgain,
      ),
    };
  }
}
