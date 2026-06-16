import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opentriviadb/features/history/domain/usecases/get_history_usecase.dart';

import '../../../../core/constants/app_strings.dart';
import '../../domain/usecases/clear_history_usecase.dart';
import '../../domain/usecases/get_highest_score_usecase.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({
    required GetQuizHistoryUseCase getQuizHistoryUseCase,
    required GetHighestScoreUseCase getHighestScoreUseCase,
    required ClearHistoryUseCase clearHistoryUseCase,
  }) : _getQuizHistoryUseCase = getQuizHistoryUseCase,
       _getHighestScoreUseCase = getHighestScoreUseCase,
       _clearHistoryUseCase = clearHistoryUseCase,
       super(const HistoryState());

  final GetQuizHistoryUseCase _getQuizHistoryUseCase;
  final GetHighestScoreUseCase _getHighestScoreUseCase;
  final ClearHistoryUseCase _clearHistoryUseCase;

  Future<void> loadHistory() async {
    emit(state.copyWith(status: HistoryStatus.loading));

    try {
      final entries = await _getQuizHistoryUseCase();
      final highestScore = await _getHighestScoreUseCase();

      emit(
        state.copyWith(
          status: entries.isEmpty ? HistoryStatus.empty : HistoryStatus.ready,
          entries: entries,
          highestScore: highestScore,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: HistoryStatus.failure,
          errorMessage: AppStrings.historyLoadError,
        ),
      );
    }
  }

  Future<void> clearHistory() async {
    try {
      await _clearHistoryUseCase();
      emit(
        state.copyWith(
          status: HistoryStatus.empty,
          entries: const [],
          highestScore: 0,
          errorMessage: null,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: HistoryStatus.failure,
          errorMessage: AppStrings.historyClearError,
        ),
      );
    }
  }
}
