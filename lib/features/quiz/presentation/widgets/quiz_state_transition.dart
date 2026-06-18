import 'package:flutter/material.dart';

import '../../../../core/theme/app_motion.dart';
import '../constants/quiz_dimensions.dart';
import '../cubits/quiz_state.dart';
import 'quiz_state_view.dart';

class QuizStateTransition extends StatelessWidget {
  const QuizStateTransition({
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
      transitionBuilder: _buildTransition,
      child: KeyedSubtree(
        key: ValueKey(_contentKey(state.status)),
        child: QuizStateView(
          state: state,
          onExitRequested: onExitRequested,
          onPlayAgain: onPlayAgain,
        ),
      ),
    );
  }

  static Widget _buildTransition(Widget child, Animation<double> animation) {
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
      end: QuizDimensions.maximumProgress,
    ).animate(curvedAnimation);

    return FadeTransition(
      opacity: curvedAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: ScaleTransition(scale: scaleAnimation, child: child),
      ),
    );
  }

  static _QuizContentKey _contentKey(QuizStatus status) {
    return switch (status) {
      QuizStatus.initial || QuizStatus.loading => _QuizContentKey.loading,
      QuizStatus.inProgress ||
      QuizStatus.answerRevealed => _QuizContentKey.question,
      QuizStatus.completed => _QuizContentKey.completed,
      QuizStatus.empty => _QuizContentKey.empty,
      QuizStatus.failure => _QuizContentKey.failure,
    };
  }
}

enum _QuizContentKey { loading, question, completed, empty, failure }
