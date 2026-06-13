import '../../domain/entities/quiz_result.dart';

class QuizResultModel extends QuizResult {
  const QuizResultModel({
    required super.score,
    required super.totalQuestions,
    required super.completedAt,
    super.categoryName,
    super.difficulty,
  });

  factory QuizResultModel.fromEntity(QuizResult result) {
    return QuizResultModel(
      score: result.score,
      totalQuestions: result.totalQuestions,
      completedAt: result.completedAt,
      categoryName: result.categoryName,
      difficulty: result.difficulty,
    );
  }

  QuizResult toEntity() {
    return QuizResult(
      score: score,
      totalQuestions: totalQuestions,
      completedAt: completedAt,
      categoryName: categoryName,
      difficulty: difficulty,
    );
  }

  fromMap(Map<String, dynamic> map) {
    return QuizResultModel(
      score: map['score'],
      totalQuestions: map['totalQuestions'],
      completedAt: DateTime.parse(map['completedAt']),
      categoryName: map['categoryName'],
      difficulty: map['difficulty'],
    );
  }
}
