import '../../../../core/error/app_exception.dart';
import '../constants/open_trivia_api_constants.dart';
import '../constants/quiz_data_error_messages.dart';
import '../models/quiz_category_model.dart';
import '../models/quiz_question_model.dart';

class OpenTriviaResponseParser {
  const OpenTriviaResponseParser();

  List<QuizCategoryModel> parseCategories(Map<String, dynamic>? data) {
    final categoriesJson =
        data?[OpenTriviaApiConstants.responseTriviaCategories];

    if (categoriesJson is! List) {
      throw const ServerException(
        QuizDataErrorMessages.categoryResponseFormatInvalid,
      );
    }

    final categories = categoriesJson
        .map((json) => QuizCategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();

    if (categories.isEmpty) {
      throw const EmptyResultException(QuizDataErrorMessages.noCategoriesFound);
    }

    return categories;
  }

  List<QuizQuestionModel> parseQuestions(Map<String, dynamic>? data) {
    final responseCode = data?[OpenTriviaApiConstants.responseCode];
    final resultsJson = data?[OpenTriviaApiConstants.responseResults];

    if (responseCode is! num || resultsJson is! List) {
      throw const ServerException(
        QuizDataErrorMessages.questionResponseFormatInvalid,
      );
    }

    final code = responseCode.toInt();
    if (code == OpenTriviaApiConstants.noResultsResponseCode ||
        resultsJson.isEmpty) {
      throw const EmptyResultException(QuizDataErrorMessages.noQuestionsFound);
    }

    if (code != OpenTriviaApiConstants.successResponseCode) {
      throw ServerException(
        QuizDataErrorMessages.questionRequestFailedWithResponseCode(code),
      );
    }

    return resultsJson
        .map((json) => QuizQuestionModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
