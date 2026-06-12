import '../../../quiz/data/models/quiz_result_model.dart';

abstract interface class HistoryLocalDataSource {
  Future<List<QuizResultModel>> getHistory();

  Future<void> clearHistory();
}

class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  const HistoryLocalDataSourceImpl();

  @override
  Future<List<QuizResultModel>> getHistory() {
    // TODO: Read saved quiz results from Hive.
    throw UnimplementedError();
  }

  @override
  Future<void> clearHistory() {
    // TODO: Clear saved quiz results from Hive.
    throw UnimplementedError();
  }
}
