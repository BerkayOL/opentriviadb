import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_spacing.dart';
import 'quiz_setup_palette.dart';

class SetupHeader extends StatelessWidget {
  const SetupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.brandName,
                style: textTheme.labelLarge?.copyWith(
                  color: QuizSetupPalette.primaryText(context),
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          AppStrings.appName,
          style: textTheme.displaySmall?.copyWith(
            color: QuizSetupPalette.secondaryText(context),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          AppStrings.setupSubtitle,
          style: textTheme.bodyLarge?.copyWith(
            color: QuizSetupPalette.primaryText(context),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
