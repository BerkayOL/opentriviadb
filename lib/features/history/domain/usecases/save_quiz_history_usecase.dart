import '../entities/quiz_history_entry.dart';
import '../repositories/history_repository.dart';

class SaveQuizHistoryUseCase {
  const SaveQuizHistoryUseCase(this._repository);

  final HistoryRepository _repository;

  Future<void> call(QuizHistoryEntry entry) => _repository.saveResult(entry);
}
