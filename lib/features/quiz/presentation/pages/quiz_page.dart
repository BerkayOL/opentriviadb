import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_motion.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import '../constants/quiz_dimensions.dart';
import '../theme/quiz_palette.dart';
import '../widgets/quiz_completed_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/empty_view.dart';
import '../widgets/quiz_loading_view.dart';
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
                return AnimatedSwitcher(
                  duration: AppMotion.slow,
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  layoutBuilder: (currentChild, previousChildren) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [...previousChildren, ?currentChild],
                    );
                  },
                  transitionBuilder: _buildPageTransition,
                  child: KeyedSubtree(
                    key: ValueKey(_pageTransitionKey(state.status)),
                    child: _buildQuizContent(context, state),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildPageTransition(
    Widget child,
    Animation<double> animation,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, QuizDimensions.pageTransitionSlideY),
      end: Offset.zero,
    ).animate(curvedAnimation);
    final scaleAnimation = Tween<double>(
      begin: QuizDimensions.pageTransitionBeginScale,
      end: 1,
    ).animate(curvedAnimation);

    return FadeTransition(
      opacity: curvedAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: ScaleTransition(scale: scaleAnimation, child: child),
      ),
    );
  }

  static Widget _buildQuizContent(BuildContext context, QuizState state) {
    switch (state.status) {
      case QuizStatus.initial:
      case QuizStatus.loading:
        return const QuizLoadingView();
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
      case QuizStatus.answerRevealed:
        return QuestionView(state: state);
      case QuizStatus.completed:
        return QuizCompletedView(state: state);
    }
  }

  static String _pageTransitionKey(QuizStatus status) {
    return switch (status) {
      QuizStatus.initial || QuizStatus.loading => 'loading',
      QuizStatus.inProgress || QuizStatus.answerRevealed => 'question',
      QuizStatus.completed => 'completed',
      QuizStatus.empty => 'empty',
      QuizStatus.failure => 'failure',
    };
  }
}
