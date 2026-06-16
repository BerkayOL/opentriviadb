abstract final class QuizDataErrorMessages {
  static const String categoryResponseFormatInvalid =
      'Category response format is invalid.';
  static const String noCategoriesFound = 'No categories found.';
  static const String checkInternetConnection =
      'Check your internet connection.';
  static const String categoryResponseContainsInvalidData =
      'Category response contains invalid data.';
  static const String questionResponseFormatInvalid =
      'Question response format is invalid.';
  static const String noQuestionsFound = 'No questions found.';
  static const String questionResponseContainsInvalidData =
      'Question response contains invalid data.';
  static const String invalidQuizQuestionFormat =
      'Invalid quiz question format.';
  static const String invalidAnswerFormat = 'Invalid answer format.';
  static const String invalidQuizCategoryFormat =
      'Invalid quiz category format.';
  static const String unknownStatusCode = 'unknown';

  static String categoryRequestFailedWithStatus(Object statusCode) {
    return 'Category request failed with status $statusCode.';
  }

  static String questionRequestFailedWithStatus(Object statusCode) {
    return 'Question request failed with status $statusCode.';
  }

  static String questionRequestFailedWithResponseCode(int responseCode) {
    return 'Question request failed with response code $responseCode.';
  }
}
