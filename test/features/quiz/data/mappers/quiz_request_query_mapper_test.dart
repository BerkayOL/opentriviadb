import 'package:flutter_test/flutter_test.dart';
import 'package:opentriviadb/features/quiz/data/mappers/quiz_request_query_mapper.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_request.dart';

void main() {
  const mapper = QuizRequestQueryMapper();

  test('maps selected quiz settings to Open Trivia query parameters', () {
    const request = QuizRequest(
      amount: 10,
      categoryId: 9,
      difficulty: 'easy',
      type: 'multiple',
    );

    expect(mapper.toQueryParameters(request), {
      'amount': 10,
      'category': 9,
      'difficulty': 'easy',
      'type': 'multiple',
    });
  });

  test('omits optional query parameters when they are not selected', () {
    const request = QuizRequest(amount: 5, type: 'boolean');

    expect(mapper.toQueryParameters(request), {'amount': 5, 'type': 'boolean'});
  });
}
