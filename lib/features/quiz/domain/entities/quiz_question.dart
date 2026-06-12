import 'package:equatable/equatable.dart';

class QuizQuestion extends Equatable {
  const QuizQuestion({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.answers,
    required this.category,
    required this.difficulty,
    required this.type,
  });

  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final List<String> answers;
  final String category;
  final String difficulty;
  final String type;

  @override
  List<Object?> get props => [
    question,
    correctAnswer,
    incorrectAnswers,
    answers,
    category,
    difficulty,
    type,
  ];
}
