import 'package:flutter_test/flutter_test.dart';
import 'package:opentriviadb/core/constants/app_strings.dart';
import 'package:opentriviadb/core/error/failure.dart';
import 'package:opentriviadb/features/history/domain/entities/quiz_history_entry.dart';
import 'package:opentriviadb/features/history/domain/repositories/history_repository.dart';
import 'package:opentriviadb/features/history/domain/usecases/save_quiz_history_usecase.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_category.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_question.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_request.dart';
import 'package:opentriviadb/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:opentriviadb/features/quiz/domain/usecases/get_questions_usecase.dart';
import 'package:opentriviadb/features/quiz/presentation/cubits/quiz_cubit.dart';
import 'package:opentriviadb/features/quiz/presentation/cubits/quiz_state.dart';

void main() {
  group('QuizCubit', () {
    const request = QuizRequest(amount: 2);
    const firstQuestion = QuizQuestion(
      question: 'What is 2 + 2?',
      correctAnswer: '4',
      incorrectAnswers: ['1', '2', '3'],
      answers: ['4', '1', '2', '3'],
      category: 'Math',
      difficulty: 'easy',
      type: 'multiple',
    );
    const secondQuestion = QuizQuestion(
      question: 'What is the capital of France?',
      correctAnswer: 'Paris',
      incorrectAnswers: ['Rome', 'Madrid', 'Berlin'],
      answers: ['Paris', 'Rome', 'Madrid', 'Berlin'],
      category: 'Geography',
      difficulty: 'easy',
      type: 'multiple',
    );

    test('selectAnswer reveals correct answer and increments score', () async {
      final cubit = _buildCubit(questions: const [firstQuestion]);

      await cubit.startQuiz(request);
      cubit.selectAnswer(firstQuestion.correctAnswer);

      expect(cubit.state.status, QuizStatus.answerRevealed);
      expect(cubit.state.score, 1);
      expect(cubit.state.selectedAnswer, firstQuestion.correctAnswer);
      expect(cubit.state.isAnswerCorrect, isTrue);

      await cubit.close();
    });

    test(
      'nextQuestion moves to next question and resets answer state',
      () async {
        final cubit = _buildCubit(
          questions: const [firstQuestion, secondQuestion],
        );

        await cubit.startQuiz(request);
        cubit.selectAnswer(firstQuestion.correctAnswer);
        await cubit.nextQuestion();

        expect(cubit.state.status, QuizStatus.inProgress);
        expect(cubit.state.currentIndex, 1);
        expect(cubit.state.selectedAnswer, isNull);
        expect(cubit.state.isAnswerCorrect, isNull);
        expect(cubit.state.score, 1);

        await cubit.close();
      },
    );

    test(
      'nextQuestion completes quiz and saves history on last question',
      () async {
        final historyRepository = _FakeHistoryRepository();
        final cubit = _buildCubit(
          questions: const [firstQuestion],
          historyRepository: historyRepository,
        );

        await cubit.startQuiz(request);
        cubit.selectAnswer(firstQuestion.correctAnswer);
        await cubit.nextQuestion();

        expect(cubit.state.status, QuizStatus.completed);
        expect(historyRepository.savedEntries, hasLength(1));
        expect(historyRepository.savedEntries.single.score, 1);
        expect(historyRepository.savedEntries.single.totalQuestions, 1);

        await cubit.close();
      },
    );

    testWidgets(
      'timer timeout reveals an unanswered wrong result without changing score',
      (tester) async {
        final cubit = _buildCubit(questions: const [firstQuestion]);

        await cubit.startQuiz(request);
        await tester.pump(const Duration(seconds: 30));

        expect(cubit.state.status, QuizStatus.answerRevealed);
        expect(cubit.state.secondsLeft, 0);
        expect(cubit.state.selectedAnswer, isNull);
        expect(cubit.state.isAnswerCorrect, isFalse);
        expect(cubit.state.score, 0);

        await cubit.close();
      },
    );

    test(
      'history save failure completes quiz with a consumable warning',
      () async {
        final historyRepository = _FakeHistoryRepository(shouldFailSave: true);
        final cubit = _buildCubit(
          questions: const [firstQuestion],
          historyRepository: historyRepository,
        );

        await cubit.startQuiz(request);
        cubit.selectAnswer(firstQuestion.correctAnswer);
        await cubit.nextQuestion();

        expect(cubit.state.status, QuizStatus.completed);
        expect(cubit.state.score, 1);
        expect(cubit.state.warningMessage, AppStrings.historySaveError);

        cubit.clearWarningMessage();

        expect(cubit.state.status, QuizStatus.completed);
        expect(cubit.state.warningMessage, isNull);

        await cubit.close();
      },
    );

    test('retryQuiz without previous request emits failure', () async {
      final cubit = _buildCubit(questions: const [firstQuestion]);

      await cubit.retryQuiz();

      expect(cubit.state.status, QuizStatus.failure);
      expect(cubit.state.errorMessage, AppStrings.quizSettingsMissing);

      await cubit.close();
    });

    test('empty result failure emits empty state and retry recovers', () async {
      final repository = _EmptyThenQuestionsQuizRepository(const [
        firstQuestion,
      ]);
      final cubit = QuizCubit(
        GetQuestionsUseCase(repository),
        SaveQuizHistoryUseCase(_FakeHistoryRepository()),
      );

      await cubit.startQuiz(request);

      expect(cubit.state.status, QuizStatus.empty);
      expect(cubit.state.errorMessage, isNull);

      await cubit.retryQuiz();

      expect(cubit.state.status, QuizStatus.inProgress);
      expect(cubit.state.questions, hasLength(1));

      await cubit.close();
    });
  });
}

QuizCubit _buildCubit({
  required List<QuizQuestion> questions,
  _FakeHistoryRepository? historyRepository,
}) {
  final repository = _FakeQuizRepository(questions);
  final history = historyRepository ?? _FakeHistoryRepository();

  return QuizCubit(
    GetQuestionsUseCase(repository),
    SaveQuizHistoryUseCase(history),
  );
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

class _EmptyThenQuestionsQuizRepository implements QuizRepository {
  _EmptyThenQuestionsQuizRepository(this._questions);

  final List<QuizQuestion> _questions;
  bool _hasReturnedEmptyResult = false;

  @override
  Future<List<QuizCategory>> getCategories() async {
    return const [];
  }

  @override
  Future<List<QuizQuestion>> getQuestions(QuizRequest request) async {
    if (!_hasReturnedEmptyResult) {
      _hasReturnedEmptyResult = true;
      throw const EmptyResultFailure('No questions found.');
    }

    return _questions;
  }
}

class _FakeHistoryRepository implements HistoryRepository {
  _FakeHistoryRepository({this.shouldFailSave = false});

  final bool shouldFailSave;
  final List<QuizHistoryEntry> savedEntries = [];

  @override
  Future<void> saveResult(QuizHistoryEntry entry) async {
    if (shouldFailSave) {
      throw StateError('History save failed.');
    }
    savedEntries.add(entry);
  }

  @override
  Future<List<QuizHistoryEntry>> getHistory() async {
    return savedEntries;
  }

  @override
  Future<void> clearHistory() async {
    savedEntries.clear();
  }

  @override
  Future<int> getHighestScore() async {
    if (savedEntries.isEmpty) {
      return 0;
    }

    return savedEntries
        .map((entry) => entry.score)
        .reduce((highest, score) => score > highest ? score : highest);
  }
}
