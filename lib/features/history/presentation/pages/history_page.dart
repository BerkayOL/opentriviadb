import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/empty_view.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: const Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: EmptyView(
          title: 'No quiz history yet',
          message: 'Completed quiz results will appear here.',
        ),
      ),
    );
  }
}
