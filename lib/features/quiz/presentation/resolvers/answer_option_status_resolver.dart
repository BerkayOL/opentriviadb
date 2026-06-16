import '../cubits/quiz_state.dart';
import '../models/answer_option_status.dart';

AnswerOptionStatus resolveAnswerStatus({
  required QuizState state,
  required String answer,
  required String correctAnswer,
}) {
  final isSelected = answer == state.selectedAnswer;
  final isCorrect = answer == correctAnswer;

  if (state.status == QuizStatus.answerRevealed) {
    if (isCorrect) {
      return AnswerOptionStatus.correct;
    }

    if (isSelected) {
      return AnswerOptionStatus.wrong;
    }

    return AnswerOptionStatus.idle;
  }

  if (isSelected) {
    return AnswerOptionStatus.selected;
  }

  return AnswerOptionStatus.idle;
}
