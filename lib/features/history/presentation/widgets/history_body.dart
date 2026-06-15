import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../cubits/history_cubit.dart';
import '../cubits/history_state.dart';
import 'history_list_view.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({super.key, required this.state});

  final HistoryState state;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case HistoryStatus.initial:
      case HistoryStatus.loading:
        return const LoadingView();

      case HistoryStatus.failure:
        return ErrorView(
          message: state.errorMessage ?? AppStrings.genericError,
          onRetry: () {
            context.read<HistoryCubit>().loadHistory();
          },
        );

      case HistoryStatus.empty:
        return const EmptyView(
          title: AppStrings.noHistoryTitle,
          message: AppStrings.noHistoryMessage,
        );

      case HistoryStatus.ready:
        return HistoryListView(
          entries: state.entries,
          highestScore: state.highestScore,
        );
    }
  }
}
