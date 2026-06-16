import 'package:flutter/material.dart';
import '../../../../../core/widgets/app_card.dart';

class SetupOptionCard extends StatelessWidget {
  const SetupOptionCard({required this.title, required this.value, super.key});

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: textTheme.titleSmall),
        ],
      ),
    );
  }
}
