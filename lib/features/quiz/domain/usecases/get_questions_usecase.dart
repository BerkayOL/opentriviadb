import 'dart:math';

import '../entities/quiz_question.dart';
import '../entities/quiz_request.dart';
import '../repositories/quiz_repository.dart';
import '../utils/answer_shuffle.dart';

class GetQuestionsUseCase {
  const GetQuestionsUseCase(this._repository, {Random? random})
    : _random = random;

  final QuizRepository _repository;
  final Random? _random;

  Future<List<QuizQuestion>> call(QuizRequest request) async {
    final questions = await _repository.getQuestions(request);

    return questions.map((question) {
      return QuizQuestion(
        question: question.question,
        correctAnswer: question.correctAnswer,
        incorrectAnswers: question.incorrectAnswers,
        answers: shuffleAnswers(
          correctAnswer: question.correctAnswer,
          incorrectAnswers: question.incorrectAnswers,
          random: _random,
        ),
        category: question.category,
        difficulty: question.difficulty,
        type: question.type,
      );
    }).toList();
  }
}
