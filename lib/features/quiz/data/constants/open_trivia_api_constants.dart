abstract final class OpenTriviaApiConstants {
  static const String baseUrl = 'https://opentdb.com';
  static const String categoriesEndpoint = '/api_category.php';
  static const String questionsEndpoint = '/api.php';

  static const String queryAmount = 'amount';
  static const String queryCategory = 'category';
  static const String queryDifficulty = 'difficulty';
  static const String queryType = 'type';

  static const String responseTriviaCategories = 'trivia_categories';
  static const String responseCode = 'response_code';
  static const String responseResults = 'results';

  static const String fieldId = 'id';
  static const String fieldName = 'name';
  static const String fieldQuestion = 'question';
  static const String fieldCorrectAnswer = 'correct_answer';
  static const String fieldIncorrectAnswers = 'incorrect_answers';
  static const String fieldCategory = 'category';
  static const String fieldDifficulty = 'difficulty';
  static const String fieldType = 'type';

  static const int successResponseCode = 0;
  static const int noResultsResponseCode = 1;
}
