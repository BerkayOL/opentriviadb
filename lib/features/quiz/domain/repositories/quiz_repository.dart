import '../entities/quiz_category.dart';
import '../entities/quiz_question.dart';
import '../entities/quiz_request.dart';
import '../entities/quiz_result.dart';

abstract interface class QuizRepository {
  Future<List<QuizCategory>> getCategories();

  Future<List<QuizQuestion>> getQuestions(QuizRequest request);

  Future<void> saveQuizResult(QuizResult result);
}
