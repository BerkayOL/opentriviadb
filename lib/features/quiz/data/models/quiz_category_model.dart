import '../../domain/entities/quiz_category.dart';

class QuizCategoryModel extends QuizCategory {
  const QuizCategoryModel({required super.id, required super.name});

  factory QuizCategoryModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];

    if (id is! num || name is! String) {
      throw const FormatException('Invalid quiz category format.');
    }

    return QuizCategoryModel(id: id.toInt(), name: name);
  }

  QuizCategory toEntity() => QuizCategory(id: id, name: name);
}
