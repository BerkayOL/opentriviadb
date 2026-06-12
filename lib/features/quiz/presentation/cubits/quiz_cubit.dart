import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';

import '../../domain/entities/quiz_request.dart';
import '../../domain/usecases/get_questions_usecase.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this._getQuestionsUseCase) : super(const QuizState());

  final GetQuestionsUseCase _getQuestionsUseCase;
  QuizRequest? _lastRequest;
  Future<void> startQuiz(QuizRequest request) async {
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
        ),
      );
    } on Failure catch (failure) {
      emit(
        QuizState(status: QuizStatus.failure, errorMessage: failure.message),
      );
    } catch (_) {
      emit(
        QuizState(
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

  void nextQuestion() {
    if (state.status != QuizStatus.answerRevealed) {
      return;
    }

    if (state.isLastQuestion) {
      emit(state.copyWith(status: QuizStatus.completed));
      return;
    }

    emit(
      state.copyWith(
        status: QuizStatus.inProgress,
        currentIndex: state.currentIndex + 1,
        selectedAnswer: null,
        isAnswerCorrect: null,
      ),
    );
  }
}
