import '../entities/quiz_category.dart';
import '../entities/quiz_question.dart';
import '../entities/quiz_request.dart';

abstract interface class QuizRepository {
  Future<List<QuizCategory>> getCategories();

  Future<List<QuizQuestion>> getQuestions(QuizRequest request);
}
