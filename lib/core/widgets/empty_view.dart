import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({required this.title, super.key, this.message});

  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 40),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(message!, textAlign: TextAlign.center),
            ],
          ],
        ),
      ),
    );
  }
}
