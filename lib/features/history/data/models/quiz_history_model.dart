import '../../domain/entities/quiz_history_entry.dart';
import '../constants/history_storage_keys.dart';

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
      id: map[HistoryStorageKeys.id] as String,
      score: map[HistoryStorageKeys.score] as int,
      totalQuestions: map[HistoryStorageKeys.totalQuestions] as int,
      createdAt: DateTime.parse(map[HistoryStorageKeys.createdAt] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      HistoryStorageKeys.id: id,
      HistoryStorageKeys.score: score,
      HistoryStorageKeys.totalQuestions: totalQuestions,
      HistoryStorageKeys.createdAt: createdAt.toIso8601String(),
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
