import '../entities/quiz_result.dart';
import '../repositories/quiz_repository.dart';

class SaveQuizResultUseCase {
  const SaveQuizResultUseCase(this._repository);

  final QuizRepository _repository;

  Future<void> call(QuizResult result) => _repository.saveQuizResult(result);
}
