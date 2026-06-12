import '../../domain/entities/quiz_request.dart';
import '../models/quiz_category_model.dart';
import '../models/quiz_question_model.dart';

abstract interface class QuizRemoteDataSource {
  Future<List<QuizCategoryModel>> fetchCategories();

  Future<List<QuizQuestionModel>> fetchQuestions(QuizRequest request);
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  const QuizRemoteDataSourceImpl();

  @override
  Future<List<QuizCategoryModel>> fetchCategories() {
    // TODO: Implement Dio request to OpenTDB categories endpoint.
    throw UnimplementedError();
  }

  @override
  Future<List<QuizQuestionModel>> fetchQuestions(QuizRequest request) {
    // TODO: Implement Dio request to OpenTDB questions endpoint.
    throw UnimplementedError();
  }
}
