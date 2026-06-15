import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});
  final String loadingMessage = AppStrings.loadingQuestions;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppSpacing.md),
          Text(loadingMessage, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
