import '../../domain/constants/quiz_config.dart';
import '../../domain/entities/quiz_question.dart';
import '../cubits/quiz_state.dart';

abstract final class QuizStateFactory {
  static QuizState started(List<QuizQuestion> questions) {
    return QuizState(
      status: QuizStatus.inProgress,
      questions: questions,
      currentIndex: 0,
      score: 0,
      selectedAnswer: null,
      isAnswerCorrect: null,
      secondsLeft: QuizConfig.questionDurationSeconds,
    );
  }

  static QuizState failure(String message) {
    return QuizState(status: QuizStatus.failure, errorMessage: message);
  }

  static QuizState answerRevealed(
    QuizState state, {
    required String? answer,
    required bool isCorrect,
  }) {
    return state.copyWith(
      status: QuizStatus.answerRevealed,
      selectedAnswer: answer,
      isAnswerCorrect: isCorrect,
      score: isCorrect ? state.score + 1 : state.score,
    );
  }

  static QuizState nextQuestion(QuizState state) {
    return state.copyWith(
      status: QuizStatus.inProgress,
      currentIndex: state.currentIndex + 1,
      selectedAnswer: null,
      isAnswerCorrect: null,
      secondsLeft: QuizConfig.questionDurationSeconds,
    );
  }

  static QuizState completed(QuizState state, {String? warningMessage}) {
    return state.copyWith(
      status: QuizStatus.completed,
      warningMessage: warningMessage,
    );
  }
}
