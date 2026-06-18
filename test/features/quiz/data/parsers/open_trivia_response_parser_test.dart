import 'package:flutter_test/flutter_test.dart';
import 'package:opentriviadb/core/error/app_exception.dart';
import 'package:opentriviadb/features/quiz/data/parsers/open_trivia_response_parser.dart';

void main() {
  const parser = OpenTriviaResponseParser();

  group('OpenTriviaResponseParser', () {
    test('parses categories from a valid response', () {
      final categories = parser.parseCategories({
        'trivia_categories': [
          {'id': 9, 'name': 'General Knowledge'},
        ],
      });

      expect(categories.single.id, 9);
      expect(categories.single.name, 'General Knowledge');
    });

    test('maps no question results to EmptyResultException', () {
      expect(
        () => parser.parseQuestions({
          'response_code': 1,
          'results': <Map<String, dynamic>>[],
        }),
        throwsA(isA<EmptyResultException>()),
      );
    });
  });
}
