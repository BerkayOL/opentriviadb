import 'package:equatable/equatable.dart';

import '../../domain/entities/quiz_question.dart';

enum QuizStatus { initial, loading, inProgress, completed, failure }

class QuizState extends Equatable {
  const QuizState({
    this.status = QuizStatus.initial,
    this.questions = const [],
    this.currentIndex = 0,
    this.score = 0,
    this.errorMessage,
  });

  final QuizStatus status;
  final List<QuizQuestion> questions;
  final int currentIndex;
  final int score;
  final String? errorMessage;

  @override
  List<Object?> get props => [
    status,
    questions,
    currentIndex,
    score,
    errorMessage,
  ];
}
