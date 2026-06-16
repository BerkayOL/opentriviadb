import '../../domain/utils/answer_shuffle.dart';
import '../../../../core/utils/html_text_decoder.dart';
import '../../domain/entities/quiz_question.dart';
import '../constants/quiz_data_error_messages.dart';

class QuizQuestionModel extends QuizQuestion {
  const QuizQuestionModel({
    required super.question,
    required super.correctAnswer,
    required super.incorrectAnswers,
    required super.answers,
    required super.category,
    required super.difficulty,
    required super.type,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    final question = json['question'];
    final correctAnswer = json['correct_answer'];
    final incorrectAnswers = json['incorrect_answers'];
    final category = json['category'];
    final difficulty = json['difficulty'];
    final type = json['type'];

    if (question is! String ||
        correctAnswer is! String ||
        incorrectAnswers is! List ||
        category is! String ||
        difficulty is! String ||
        type is! String) {
      throw const FormatException(
        QuizDataErrorMessages.invalidQuizQuestionFormat,
      );
    }

    final decodedCorrectAnswer = HtmlTextDecoder.decode(correctAnswer);
    final decodedIncorrectAnswers = incorrectAnswers
        .map((answer) {
          if (answer is! String) {
            throw const FormatException(
              QuizDataErrorMessages.invalidAnswerFormat,
            );
          }
          return HtmlTextDecoder.decode(answer);
        })
        .toList(growable: false);

    return QuizQuestionModel(
      question: HtmlTextDecoder.decode(question),
      correctAnswer: decodedCorrectAnswer,
      incorrectAnswers: decodedIncorrectAnswers,
      answers: shuffleAnswers(
        correctAnswer: decodedCorrectAnswer,
        incorrectAnswers: decodedIncorrectAnswers,
      ),
      category: HtmlTextDecoder.decode(category),
      difficulty: difficulty,
      type: type,
    );
  }

  QuizQuestion toEntity() {
    return QuizQuestion(
      question: question,
      correctAnswer: correctAnswer,
      incorrectAnswers: incorrectAnswers,
      answers: answers,
      category: category,
      difficulty: difficulty,
      type: type,
    );
  }
}
