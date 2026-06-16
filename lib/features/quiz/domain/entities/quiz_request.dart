import 'package:equatable/equatable.dart';

import '../constants/quiz_api_values.dart';
import '../constants/quiz_config.dart';

class QuizRequest extends Equatable {
  const QuizRequest({
    this.amount = QuizConfig.defaultQuestionAmount,
    this.categoryId,
    this.difficulty,
    this.type = QuizApiValues.multiple,
  });

  final int amount;
  final int? categoryId;
  final String? difficulty;
  final String type;

  @override
  List<Object?> get props => [amount, categoryId, difficulty, type];
}
