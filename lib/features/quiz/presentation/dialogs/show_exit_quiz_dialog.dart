import 'package:flutter/material.dart';

import '../theme/quiz_palette.dart';
import 'exit_quiz_dialog.dart';

Future<bool> showExitQuizDialog(BuildContext context) async {
  final shouldExit = await showDialog<bool>(
    context: context,
    barrierColor: QuizPalette.dialogBarrier(),
    builder: (_) => const ExitQuizDialog(),
  );

  return shouldExit ?? false;
}
