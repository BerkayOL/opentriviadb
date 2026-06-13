import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../history/domain/entities/quiz_history_entry.dart';
import '../../../history/domain/usecases/save_quiz_history_usecase.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/quiz_request.dart';
import '../../domain/usecases/get_questions_usecase.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this._getQuestionsUseCase, this._saveQuizHistoryUseCase)
    : super(const QuizState());

  final GetQuestionsUseCase _getQuestionsUseCase;
  final SaveQuizHistoryUseCase _saveQuizHistoryUseCase;
  Timer? _timer;
  static const int _questionDuration = 30;
  QuizRequest? _lastRequest;
  Future<void> startQuiz(QuizRequest request) async {
    _stopTimer();
    _lastRequest = request;
    emit(const QuizState(status: QuizStatus.loading));
    try {
      final questions = await _getQuestionsUseCase(request);

      if (questions.isEmpty) {
        emit(const QuizState(status: QuizStatus.empty));
        return;
      }
      emit(
        QuizState(
          status: QuizStatus.inProgress,
          questions: questions,
          currentIndex: 0,
          score: 0,
          selectedAnswer: null,
          isAnswerCorrect: null,
          secondsLeft: _questionDuration,
        ),
      );
      _startTimer();
    } on Failure catch (failure) {
      emit(
        QuizState(status: QuizStatus.failure, errorMessage: failure.message),
      );
    } catch (_) {
      emit(
        const QuizState(
          status: QuizStatus.failure,
          errorMessage: 'Failed to load questions.',
        ),
      );
    }
  }

  Future<void> retryQuiz() async {
    final request = _lastRequest;

    if (request == null) {
      emit(
        const QuizState(
          status: QuizStatus.failure,
          errorMessage: 'Quiz settings are missing.',
        ),
      );
      return;
    }

    await startQuiz(request);
  }

  void selectAnswer(String answer) {
    if (state.status != QuizStatus.inProgress) {
      return;
    }

    final currentQuestion = state.currentQuestion;
    if (currentQuestion == null) {
      return;
    }
    _stopTimer();
    final isCorrect = answer == currentQuestion.correctAnswer;

    emit(
      state.copyWith(
        status: QuizStatus.answerRevealed,
        selectedAnswer: answer,
        isAnswerCorrect: isCorrect,

        score: isCorrect ? state.score + 1 : state.score,
      ),
    );
  }

  Future<void> nextQuestion() async {
    if (state.status != QuizStatus.answerRevealed) {
      return;
    }

    if (state.isLastQuestion) {
      _stopTimer();
      final entry = QuizHistoryEntry(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        score: state.score,
        totalQuestions: state.totalQuestions,
        createdAt: DateTime.now(),
      );
      try {
        await _saveQuizHistoryUseCase(entry);
      } catch (_) {
        // History kaydı başarısız olsa bile sonuç ekranı gösterilsin.
      }

      emit(state.copyWith(status: QuizStatus.completed));
      return;
    }

    emit(
      state.copyWith(
        status: QuizStatus.inProgress,
        currentIndex: state.currentIndex + 1,
        selectedAnswer: null,
        isAnswerCorrect: null,
        secondsLeft: _questionDuration,
      ),
    );
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final secondsLeft = state.secondsLeft;

      if (secondsLeft <= 1) {
        emit(state.copyWith(secondsLeft: 0));
        _handleTimeExpired();
        return;
      }

      emit(state.copyWith(secondsLeft: secondsLeft - 1));
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _handleTimeExpired() {
    if (state.status != QuizStatus.inProgress) {
      return;
    }
    _stopTimer();
    emit(
      state.copyWith(
        status: QuizStatus.answerRevealed,
        selectedAnswer: null,
        isAnswerCorrect: false,
      ),
    );
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }
}
