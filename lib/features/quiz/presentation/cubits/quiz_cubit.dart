import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/error/failure.dart';
import '../../../history/domain/entities/quiz_history_entry.dart';
import '../../../history/domain/usecases/save_quiz_history_usecase.dart';
import '../../domain/constants/quiz_config.dart';
import '../../domain/entities/quiz_question.dart';
import '../../domain/entities/quiz_request.dart';
import '../../domain/usecases/get_questions_usecase.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this._getQuestionsUseCase, this._saveQuizHistoryUseCase)
    : super(const QuizState());

  final GetQuestionsUseCase _getQuestionsUseCase;
  final SaveQuizHistoryUseCase _saveQuizHistoryUseCase;

  Timer? _timer;
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

      _emitStartedQuiz(questions);
      _startTimer();
    } on EmptyResultFailure {
      emit(const QuizState(status: QuizStatus.empty));
    } on Failure catch (failure) {
      _emitFailure(failure.message);
    } catch (_) {
      _emitFailure(AppStrings.questionsLoadError);
    }
  }

  Future<void> retryQuiz() async {
    final request = _lastRequest;

    if (request == null) {
      _emitFailure(AppStrings.quizSettingsMissing);
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
    _revealAnswer(
      answer: answer,
      isCorrect: answer == currentQuestion.correctAnswer,
    );
  }

  Future<void> nextQuestion() async {
    if (state.status != QuizStatus.answerRevealed) {
      return;
    }

    if (state.isLastQuestion) {
      await _completeQuiz();
      return;
    }

    _advanceToNextQuestion();
    _startTimer();
  }

  void _emitStartedQuiz(List<QuizQuestion> questions) {
    emit(
      QuizState(
        status: QuizStatus.inProgress,
        questions: questions,
        currentIndex: 0,
        score: 0,
        selectedAnswer: null,
        isAnswerCorrect: null,
        secondsLeft: QuizConfig.questionDurationSeconds,
      ),
    );
  }

  void _emitFailure(String message) {
    emit(QuizState(status: QuizStatus.failure, errorMessage: message));
  }

  void _revealAnswer({required String? answer, required bool isCorrect}) {
    emit(
      state.copyWith(
        status: QuizStatus.answerRevealed,
        selectedAnswer: answer,
        isAnswerCorrect: isCorrect,
        score: isCorrect ? state.score + 1 : state.score,
      ),
    );
  }

  Future<void> _completeQuiz() async {
    _stopTimer();
    await _saveCurrentResult();
    emit(state.copyWith(status: QuizStatus.completed));
  }

  Future<void> _saveCurrentResult() async {
    try {
      await _saveQuizHistoryUseCase(_buildHistoryEntry());
    } catch (_) {
      // History save is non-critical; the result screen should still appear.
    }
  }

  QuizHistoryEntry _buildHistoryEntry() {
    final now = DateTime.now();

    return QuizHistoryEntry(
      id: now.microsecondsSinceEpoch.toString(),
      score: state.score,
      totalQuestions: state.totalQuestions,
      createdAt: now,
    );
  }

  void _advanceToNextQuestion() {
    emit(
      state.copyWith(
        status: QuizStatus.inProgress,
        currentIndex: state.currentIndex + 1,
        selectedAnswer: null,
        isAnswerCorrect: null,
        secondsLeft: QuizConfig.questionDurationSeconds,
      ),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tickTimer();
    });
  }

  void _tickTimer() {
    final secondsLeft = state.secondsLeft;

    if (secondsLeft <= 1) {
      emit(state.copyWith(secondsLeft: 0));
      _handleTimeExpired();
      return;
    }

    emit(state.copyWith(secondsLeft: secondsLeft - 1));
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
    _revealAnswer(answer: null, isCorrect: false);
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }
}
