import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../theme/quiz_palette.dart';
import 'exit_quiz_dialog.dart';

Future<void> showExitQuizDialog(BuildContext context) async {
  final shouldExit = await showDialog<bool>(
    context: context,
    barrierColor: QuizPalette.dialogBarrier(),
    builder: (_) => const ExitQuizDialog(),
  );

  if (shouldExit != true || !context.mounted) {
    return;
  }

  context.go(AppRoutes.setup);
}
