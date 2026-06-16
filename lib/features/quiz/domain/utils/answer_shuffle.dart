import 'dart:math';

List<String> shuffleAnswers({
  required String correctAnswer,
  required List<String> incorrectAnswers,
  Random? random,
}) {
  final answers = <String>[correctAnswer, ...incorrectAnswers];
  answers.shuffle(random);
  return answers;
}
