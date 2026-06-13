import '../../domain/entities/quiz_history_entry.dart';

class QuizHistoryModel {
  const QuizHistoryModel({
    required this.id,
    required this.score,
    required this.totalQuestions,
    required this.createdAt,
  });

  final String id;
  final int score;
  final int totalQuestions;
  final DateTime createdAt;

  factory QuizHistoryModel.fromEntity(QuizHistoryEntry entry) {
    return QuizHistoryModel(
      id: entry.id,
      score: entry.score,
      totalQuestions: entry.totalQuestions,
      createdAt: entry.createdAt,
    );
  }

  factory QuizHistoryModel.fromMap(Map<String, dynamic> map) {
    return QuizHistoryModel(
      id: map['id'] as String,
      score: map['score'] as int,
      totalQuestions: map['totalQuestions'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'totalQuestions': totalQuestions,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  QuizHistoryEntry toEntity() {
    return QuizHistoryEntry(
      id: id,
      score: score,
      totalQuestions: totalQuestions,
      createdAt: createdAt,
    );
  }
}
