import '../../domain/entities/quiz_request.dart';
import '../constants/open_trivia_api_constants.dart';

class QuizRequestQueryMapper {
  const QuizRequestQueryMapper();

  Map<String, dynamic> toQueryParameters(QuizRequest request) {
    return {
      OpenTriviaApiConstants.queryAmount: request.amount,
      if (request.categoryId != null)
        OpenTriviaApiConstants.queryCategory: request.categoryId,
      if (request.difficulty != null && request.difficulty!.isNotEmpty)
        OpenTriviaApiConstants.queryDifficulty: request.difficulty,
      OpenTriviaApiConstants.queryType: request.type,
    };
  }
}
