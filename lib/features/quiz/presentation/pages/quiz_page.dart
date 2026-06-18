import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import '../dialogs/show_exit_quiz_dialog.dart';
import '../widgets/quiz_page_body.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizCubit, QuizState>(
      listenWhen: (previous, current) =>
          previous.warningMessage != current.warningMessage &&
          current.warningMessage != null,
      listener: (context, state) {
        final message = state.warningMessage;
        if (message == null) {
          return;
        }

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
        context.read<QuizCubit>().clearWarningMessage();
      },
      child: QuizPageBody(
        onExitRequested: () => _exitQuiz(context),
        onPlayAgain: () => context.go(AppRoutes.setup),
      ),
    );
  }

  Future<void> _exitQuiz(BuildContext context) async {
    final shouldExit = await showExitQuizDialog(context);
    if (!context.mounted || !shouldExit) {
      return;
    }

    context.go(AppRoutes.setup);
  }
}
