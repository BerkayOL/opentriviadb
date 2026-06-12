import 'package:equatable/equatable.dart';

import '../../../../core/constants/api_constants.dart';

class QuizRequest extends Equatable {
  const QuizRequest({
    this.amount = ApiConstants.defaultQuestionAmount,
    this.categoryId,
    this.difficulty,
    this.type = ApiConstants.defaultQuestionType,
  });

  final int amount;
  final int? categoryId;
  final String? difficulty;
  final String type;

  @override
  List<Object?> get props => [amount, categoryId, difficulty, type];
}
