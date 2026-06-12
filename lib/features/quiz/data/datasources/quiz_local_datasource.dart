import '../models/quiz_result_model.dart';

abstract interface class QuizLocalDataSource {
  Future<void> saveQuizResult(QuizResultModel result);

  Future<List<QuizResultModel>> getQuizHistory();

  Future<int> getHighScore();
}

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  const QuizLocalDataSourceImpl();

  @override
  Future<void> saveQuizResult(QuizResultModel result) {
    // TODO: Persist quiz result with Hive.
    throw UnimplementedError();
  }

  @override
  Future<List<QuizResultModel>> getQuizHistory() {
    // TODO: Read quiz history from Hive.
    throw UnimplementedError();
  }

  @override
  Future<int> getHighScore() {
    // TODO: Calculate high score from stored results.
    throw UnimplementedError();
  }
}
