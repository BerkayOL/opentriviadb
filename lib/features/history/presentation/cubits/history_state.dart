import 'package:equatable/equatable.dart';

import '../../domain/entities/quiz_history_entry.dart';

enum HistoryStatus { initial, loading, ready, empty, failure }

class HistoryState extends Equatable {
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.entries = const [],
    this.highestScore = 0,
    this.errorMessage,
  });

  final HistoryStatus status;
  final List<QuizHistoryEntry> entries;
  final int highestScore;
  final String? errorMessage;

  HistoryState copyWith({
    HistoryStatus? status,
    List<QuizHistoryEntry>? entries,
    int? highestScore,
    String? errorMessage,
  }) {
    return HistoryState(
      status: status ?? this.status,
      entries: entries ?? this.entries,
      highestScore: highestScore ?? this.highestScore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, entries, highestScore, errorMessage];
}
