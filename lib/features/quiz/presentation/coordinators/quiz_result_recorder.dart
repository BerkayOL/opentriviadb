import '../../../history/domain/entities/quiz_history_entry.dart';
import '../../../history/domain/usecases/save_quiz_history_usecase.dart';

class QuizResultRecorder {
  const QuizResultRecorder(this._saveQuizHistoryUseCase);

  final SaveQuizHistoryUseCase _saveQuizHistoryUseCase;

  Future<bool> save({required int score, required int totalQuestions}) async {
    try {
      final now = DateTime.now();
      final entry = QuizHistoryEntry(
        id: now.microsecondsSinceEpoch.toString(),
        score: score,
        totalQuestions: totalQuestions,
        createdAt: now,
      );

      await _saveQuizHistoryUseCase(entry);
      return true;
    } catch (_) {
      return false;
    }
  }
}
