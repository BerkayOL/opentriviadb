import '../../../quiz/domain/entities/quiz_result.dart';
import '../repositories/history_repository.dart';

class GetHistoryUseCase {
  const GetHistoryUseCase(this._repository);

  final HistoryRepository _repository;

  Future<List<QuizResult>> call() => _repository.getHistory();
}
