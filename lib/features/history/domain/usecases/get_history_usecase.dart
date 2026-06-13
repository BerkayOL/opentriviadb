import '../entities/quiz_history_entry.dart';
import '../repositories/history_repository.dart';

class GetQuizHistoryUseCase {
  const GetQuizHistoryUseCase(this._repository);

  final HistoryRepository _repository;

  Future<List<QuizHistoryEntry>> call() {
    return _repository.getHistory();
  }
}
