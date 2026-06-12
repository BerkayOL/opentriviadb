import '../entities/quiz_question.dart';
import '../entities/quiz_request.dart';
import '../repositories/quiz_repository.dart';

class GetQuestionsUseCase {
  const GetQuestionsUseCase(this._repository);

  final QuizRepository _repository;

  Future<List<QuizQuestion>> call(QuizRequest request) {
    return _repository.getQuestions(request);
  }
}
