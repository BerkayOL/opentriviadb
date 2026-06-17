import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_category.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_question.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_request.dart';
import 'package:opentriviadb/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:opentriviadb/features/quiz/domain/usecases/get_questions_usecase.dart';

void main() {
  group('GetQuestionsUseCase', () {
    const request = QuizRequest(amount: 1);
    const question = QuizQuestion(
      question: 'What is 2 + 2?',
      correctAnswer: '4',
      incorrectAnswers: ['1', '2', '3'],
      answers: ['4', '1', '2', '3'],
      category: 'Math',
      difficulty: 'easy',
      type: 'multiple',
    );

    test('returns questions with shuffled answers', () async {
      final useCase = GetQuestionsUseCase(
        _FakeQuizRepository([question]),
        random: _ZeroRandom(),
      );

      final questions = await useCase(request);

      expect(questions.single.answers, ['1', '2', '3', '4']);
      expect(questions.single.correctAnswer, question.correctAnswer);
      expect(questions.single.incorrectAnswers, question.incorrectAnswers);
    });

    test('can be made deterministic with injected Random', () async {
      final firstUseCase = GetQuestionsUseCase(
        _FakeQuizRepository([question]),
        random: Random(1),
      );
      final secondUseCase = GetQuestionsUseCase(
        _FakeQuizRepository([question]),
        random: Random(1),
      );

      final first = await firstUseCase(request);
      final second = await secondUseCase(request);

      expect(first.single.answers, second.single.answers);
    });
  });
}

class _FakeQuizRepository implements QuizRepository {
  const _FakeQuizRepository(this._questions);

  final List<QuizQuestion> _questions;

  @override
  Future<List<QuizCategory>> getCategories() async {
    return const [];
  }

  @override
  Future<List<QuizQuestion>> getQuestions(QuizRequest request) async {
    return _questions;
  }
}

class _ZeroRandom implements Random {
  @override
  bool nextBool() {
    return false;
  }

  @override
  double nextDouble() {
    return 0;
  }

  @override
  int nextInt(int max) {
    return 0;
  }
}
