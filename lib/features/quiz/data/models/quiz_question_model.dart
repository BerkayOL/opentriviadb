import '../../domain/entities/quiz_question.dart';

class QuizQuestionModel extends QuizQuestion {
  const QuizQuestionModel({
    required super.question,
    required super.correctAnswer,
    required super.incorrectAnswers,
    required super.category,
    required super.difficulty,
    required super.type,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    // TODO: Decode HTML entities and response fields during API integration.
    return QuizQuestionModel(
      question: json['question'] as String,
      correctAnswer: json['correct_answer'] as String,
      incorrectAnswers: List<String>.from(json['incorrect_answers'] as List),
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      type: json['type'] as String,
    );
  }

  QuizQuestion toEntity() {
    return QuizQuestion(
      question: question,
      correctAnswer: correctAnswer,
      incorrectAnswers: incorrectAnswers,
      category: category,
      difficulty: difficulty,
      type: type,
    );
  }
}
