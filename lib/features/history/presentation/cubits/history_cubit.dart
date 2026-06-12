import 'package:flutter_bloc/flutter_bloc.dart';

import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(const HistoryState());

  Future<void> loadHistory() async {
    // TODO: Load history through GetHistoryUseCase.
    emit(const HistoryState(status: HistoryStatus.empty));
  }

  Future<void> clearHistory() async {
    // TODO: Clear history through ClearHistoryUseCase.
  }
}
