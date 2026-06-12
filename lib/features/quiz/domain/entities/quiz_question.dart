import 'package:equatable/equatable.dart';

class QuizQuestion extends Equatable {
  const QuizQuestion({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.category,
    required this.difficulty,
    required this.type,
  });

  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String category;
  final String difficulty;
  final String type;

  @override
  List<Object?> get props => [
    question,
    correctAnswer,
    incorrectAnswers,
    category,
    difficulty,
    type,
  ];
}
