import 'package:flutter_test/flutter_test.dart';
import 'package:opentriviadb/features/quiz/data/models/quiz_question_model.dart';

void main() {
  group('QuizQuestionModel.fromJson', () {
    const json = {
      'question': 'What is 2 + 2?',
      'correct_answer': '4',
      'incorrect_answers': ['1', '2', '3'],
      'category': 'Math',
      'difficulty': 'easy',
      'type': 'multiple',
    };

    test('produces deterministic answers for the same JSON', () {
      final first = QuizQuestionModel.fromJson(json);
      final second = QuizQuestionModel.fromJson(json);

      expect(first.answers, second.answers);
    });

    test('keeps answers in parsed correct then incorrect order', () {
      final model = QuizQuestionModel.fromJson(json);

      expect(model.answers, ['4', '1', '2', '3']);
    });
  });
}
