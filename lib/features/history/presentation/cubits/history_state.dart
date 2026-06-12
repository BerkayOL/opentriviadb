import 'package:equatable/equatable.dart';

import '../../../quiz/domain/entities/quiz_result.dart';

enum HistoryStatus { initial, loading, loaded, empty, failure }

class HistoryState extends Equatable {
  const HistoryState({
    this.status = HistoryStatus.initial,
    this.results = const [],
    this.errorMessage,
  });

  final HistoryStatus status;
  final List<QuizResult> results;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, results, errorMessage];
}
