import '../../domain/entities/quiz_category.dart';

class QuizCategoryModel extends QuizCategory {
  const QuizCategoryModel({required super.id, required super.name});

  factory QuizCategoryModel.fromJson(Map<String, dynamic> json) {
    // TODO: Finalize parsing when OpenTDB response handling is implemented.
    return QuizCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  QuizCategory toEntity() => QuizCategory(id: id, name: name);
}
