import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/error/failure.dart';
import '../../../history/domain/usecases/save_quiz_history_usecase.dart';
import '../../domain/entities/quiz_request.dart';
import '../../domain/usecases/get_questions_usecase.dart';
import '../coordinators/quiz_countdown_timer.dart';
import '../coordinators/quiz_result_recorder.dart';
import '../factories/quiz_state_factory.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(
    this._getQuestionsUseCase,
    SaveQuizHistoryUseCase saveQuizHistoryUseCase, {
    QuizCountdownTimer? countdownTimer,
  }) : _countdownTimer = countdownTimer ?? QuizCountdownTimer(),
       _resultRecorder = QuizResultRecorder(saveQuizHistoryUseCase),
       super(const QuizState());

  final GetQuestionsUseCase _getQuestionsUseCase;
  final QuizCountdownTimer _countdownTimer;
  final QuizResultRecorder _resultRecorder;

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

      emit(QuizStateFactory.started(questions));
      _startTimer();
    } on EmptyResultFailure {
      emit(const QuizState(status: QuizStatus.empty));
    } on Failure catch (failure) {
      emit(QuizStateFactory.failure(failure.message));
    } catch (_) {
      emit(QuizStateFactory.failure(AppStrings.questionsLoadError));
    }
  }

  Future<void> retryQuiz() async {
    final request = _lastRequest;

    if (request == null) {
      emit(QuizStateFactory.failure(AppStrings.quizSettingsMissing));
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
    emit(
      QuizStateFactory.answerRevealed(
        state,
        answer: answer,
        isCorrect: answer == currentQuestion.correctAnswer,
      ),
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

    emit(QuizStateFactory.nextQuestion(state));
    _startTimer();
  }

  Future<void> _completeQuiz() async {
    _stopTimer();
    final wasSaved = await _resultRecorder.save(
      score: state.score,
      totalQuestions: state.totalQuestions,
    );
    emit(
      QuizStateFactory.completed(
        state,
        warningMessage: wasSaved ? null : AppStrings.historySaveError,
      ),
    );
  }

  void clearWarningMessage() {
    if (state.warningMessage == null) {
      return;
    }

    emit(state.copyWith(warningMessage: null));
  }

  void _startTimer() {
    _countdownTimer.start(_tickTimer);
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
    _countdownTimer.stop();
  }

  void _handleTimeExpired() {
    if (state.status != QuizStatus.inProgress) {
      return;
    }

    _stopTimer();
    emit(
      QuizStateFactory.answerRevealed(state, answer: null, isCorrect: false),
    );
  }

  @override
  Future<void> close() {
    _countdownTimer.dispose();
    return super.close();
  }
}
