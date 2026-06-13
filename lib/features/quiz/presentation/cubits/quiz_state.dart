import 'package:equatable/equatable.dart';

import '../../domain/entities/quiz_question.dart';

enum QuizStatus {
  initial,
  loading,
  inProgress,
  answerRevealed,
  completed,
  empty,
  failure,
}

class QuizState extends Equatable {
  static const Object _unset = Object();
  const QuizState({
    this.status = QuizStatus.initial,
    this.questions = const [],
    this.currentIndex = 0,
    this.score = 0,
    this.secondsLeft = 30,
    this.errorMessage,
    this.isAnswerCorrect,
    this.selectedAnswer,
  });

  final QuizStatus status;
  final List<QuizQuestion> questions;
  final int currentIndex;
  final int score;
  final int secondsLeft;
  final bool? isAnswerCorrect;
  final String? selectedAnswer;
  final String? errorMessage;

  QuizState copyWith({
    QuizStatus? status,
    List<QuizQuestion>? questions,
    int? currentIndex,
    int? score,
    Object? errorMessage = _unset,
    Object? isAnswerCorrect = _unset,
    Object? selectedAnswer = _unset,
    int? secondsLeft,
  }) {
    return QuizState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      secondsLeft: secondsLeft ?? this.secondsLeft,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
      isAnswerCorrect: identical(isAnswerCorrect, _unset)
          ? this.isAnswerCorrect
          : isAnswerCorrect as bool?,
      selectedAnswer: identical(selectedAnswer, _unset)
          ? this.selectedAnswer
          : selectedAnswer as String?,
    );
  }

  @override
  List<Object?> get props => [
    status,
    questions,
    currentIndex,
    isAnswerCorrect,
    selectedAnswer,
    secondsLeft,
    score,
    errorMessage,
  ];
  QuizQuestion? get currentQuestion {
    if (questions.isEmpty) return null;
    if (currentIndex < 0 || currentIndex >= questions.length) return null;
    return questions[currentIndex];
  }

  bool get isLastQuestion {
    return questions.isNotEmpty && currentIndex == questions.length - 1;
  }

  int get totalQuestions => questions.length;
}
