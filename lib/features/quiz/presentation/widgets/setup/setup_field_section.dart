import 'package:flutter/material.dart';
import 'package:opentriviadb/features/quiz/presentation/theme/quiz_setup_palette.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../constants/quiz_dimensions.dart';

class SetupFieldSection extends StatelessWidget {
  const SetupFieldSection({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: QuizDimensions.setupSectionIconSize,
              color: QuizSetupPalette.accent(context),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: QuizSetupPalette.primaryText(
                  context,
                ).withValues(alpha: QuizDimensions.setupSectionTitleAlpha),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        child,
      ],
    );
  }
}
