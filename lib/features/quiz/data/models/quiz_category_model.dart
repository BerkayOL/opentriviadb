import '../../domain/entities/quiz_category.dart';
import '../constants/open_trivia_api_constants.dart';
import '../constants/quiz_data_error_messages.dart';

class QuizCategoryModel extends QuizCategory {
  const QuizCategoryModel({required super.id, required super.name});

  factory QuizCategoryModel.fromJson(Map<String, dynamic> json) {
    final id = json[OpenTriviaApiConstants.fieldId];
    final name = json[OpenTriviaApiConstants.fieldName];

    if (id is! num || name is! String) {
      throw const FormatException(
        QuizDataErrorMessages.invalidQuizCategoryFormat,
      );
    }

    return QuizCategoryModel(id: id.toInt(), name: name);
  }

  QuizCategory toEntity() => QuizCategory(id: id, name: name);
}
