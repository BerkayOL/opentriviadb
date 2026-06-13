import '../../domain/entities/quiz_history_entry.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_local_datasource.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  const HistoryRepositoryImpl(this._localDataSource);

  final HistoryLocalDataSource _localDataSource;

  @override
  Future<void> saveResult(QuizHistoryEntry entry) {
    return _localDataSource.saveResult(entry);
  }

  @override
  Future<List<QuizHistoryEntry>> getHistory() {
    return _localDataSource.getHistory();
  }

  @override
  Future<void> clearHistory() {
    return _localDataSource.clearHistory();
  }

  @override
  Future<int> getHighestScore() async {
    final entries = await _localDataSource.getHistory();

    if (entries.isEmpty) {
      return 0;
    }

    return entries
        .map((entry) => entry.score)
        .reduce((highest, score) => score > highest ? score : highest);
  }
}
