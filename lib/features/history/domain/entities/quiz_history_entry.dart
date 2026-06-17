import 'package:equatable/equatable.dart';

class QuizHistoryEntry extends Equatable {
  const QuizHistoryEntry({
    required this.id,
    required this.score,
    required this.totalQuestions,
    required this.createdAt,
  });

  final String id;
  final int score;
  final int totalQuestions;
  final DateTime createdAt;

  double get percentage {
    if (totalQuestions == 0) return 0;
    return score / totalQuestions;
  }

  @override
  List<Object?> get props => [id, score, totalQuestions, createdAt];
}
