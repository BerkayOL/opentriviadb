import 'package:flutter/material.dart';
import 'package:opentriviadb/core/theme/app_spacing.dart';

class AnswerOptionCard extends StatelessWidget {
  const AnswerOptionCard({
    required this.answer,
    required this.onTap,
    this.color,
    required this.selected,
    super.key,
  });
  final Color? color;
  final String answer;
  final VoidCallback onTap;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppSpacing.md);
    return AnimatedScale(
      scale: selected ? 1.02 : 1.0,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: color ?? Theme.of(context).dividerColor),
          color: color ?? Theme.of(context).colorScheme.surface,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Text(
                answer,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
