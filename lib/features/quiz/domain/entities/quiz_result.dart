import 'package:equatable/equatable.dart';

class QuizResult extends Equatable {
  const QuizResult({
    required this.score,
    required this.totalQuestions,
    required this.completedAt,
    this.categoryName,
    this.difficulty,
  });

  final int score;
  final int totalQuestions;
  final DateTime completedAt;
  final String? categoryName;
  final String? difficulty;

  @override
  List<Object?> get props => [
    score,
    totalQuestions,
    completedAt,
    categoryName,
    difficulty,
  ];
}
