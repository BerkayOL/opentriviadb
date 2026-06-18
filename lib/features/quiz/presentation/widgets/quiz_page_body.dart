import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import '../theme/quiz_palette.dart';
import 'quiz_state_transition.dart';

class QuizPageBody extends StatelessWidget {
  const QuizPageBody({
    required this.onExitRequested,
    required this.onPlayAgain,
    super.key,
  });

  final VoidCallback onExitRequested;
  final VoidCallback onPlayAgain;

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
                return QuizStateTransition(
                  state: state,
                  onExitRequested: onExitRequested,
                  onPlayAgain: onPlayAgain,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
