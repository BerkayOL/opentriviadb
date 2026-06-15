import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/loading_view.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import '../theme/quiz_palette.dart';
import '../widgets/quiz_completed_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/empty_view.dart';
import '../widgets/quiz_question_view.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: QuizPalette.backgroundGradient(context),
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<QuizCubit, QuizState>(
              builder: (context, state) {
                switch (state.status) {
                  case QuizStatus.initial:
                  case QuizStatus.loading:
                    return const LoadingView();
                  case QuizStatus.failure:
                    return ErrorView(
                      message: state.errorMessage ?? AppStrings.genericError,
                      onRetry: () {
                        context.read<QuizCubit>().retryQuiz();
                      },
                    );
                  case QuizStatus.empty:
                    return const EmptyView(
                      title: AppStrings.noQuestionsTitle,
                      message: AppStrings.noQuestionsMessage,
                    );
                  case QuizStatus.inProgress:
                    return QuestionView(state: state);
                  case QuizStatus.completed:
                    return CompletedView(state: state);
                  case QuizStatus.answerRevealed:
                    return QuestionView(state: state);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
