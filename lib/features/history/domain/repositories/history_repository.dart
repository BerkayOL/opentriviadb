import '../entities/quiz_history_entry.dart';

abstract interface class HistoryRepository {
  Future<void> saveResult(QuizHistoryEntry entry);

  Future<List<QuizHistoryEntry>> getHistory();

  Future<void> clearHistory();

  Future<int> getHighestScore();
}
