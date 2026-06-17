import 'package:flutter/material.dart';

import 'clear_history_dialog.dart';

Future<bool> showClearHistoryDialog(BuildContext context) async {
  final shouldClear = await showDialog<bool>(
    context: context,
    builder: (_) => const ClearHistoryDialog(),
  );

  return shouldClear ?? false;
}
