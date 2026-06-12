import '../../../quiz/domain/entities/quiz_result.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_local_datasource.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  const HistoryRepositoryImpl(this._localDataSource);

  final HistoryLocalDataSource _localDataSource;

  @override
  Future<List<QuizResult>> getHistory() async {
    final models = await _localDataSource.getHistory();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> clearHistory() => _localDataSource.clearHistory();
}
