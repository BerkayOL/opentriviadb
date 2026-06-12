import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/app_card.dart';
import '../../../quiz/domain/entities/quiz_result.dart';

class HistoryResultCard extends StatelessWidget {
  const HistoryResultCard({required this.result, super.key});

  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().add_Hm().format(
      result.completedAt,
    );

    return AppCard(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('${result.score}/${result.totalQuestions} correct'),
        subtitle: Text(formattedDate),
      ),
    );
  }
}
