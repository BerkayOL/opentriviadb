import '../repositories/history_repository.dart';

class GetHighestScoreUseCase {
  const GetHighestScoreUseCase(this._repository);

  final HistoryRepository _repository;

  Future<int> call() {
    return _repository.getHighestScore();
  }
}
