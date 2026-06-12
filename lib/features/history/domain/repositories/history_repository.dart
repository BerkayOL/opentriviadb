import '../../../quiz/domain/entities/quiz_result.dart';

abstract interface class HistoryRepository {
  Future<List<QuizResult>> getHistory();

  Future<void> clearHistory();
}
