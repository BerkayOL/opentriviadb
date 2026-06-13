import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/quiz_history_entry.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubits/history_cubit.dart';
import '../cubits/history_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: SafeArea(
        child: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            switch (state.status) {
              case HistoryStatus.initial:
              case HistoryStatus.loading:
                return const LoadingView();
              case HistoryStatus.failure:
                return ErrorView(
                  message: state.errorMessage ?? 'An error occurred.',
                  onRetry: () {
                    context.read<HistoryCubit>().loadHistory();
                  },
                );
              case HistoryStatus.empty:
                return const EmptyView(
                  title: 'No history found.',
                  message: 'You have not completed any quizzes yet.',
                );
              case HistoryStatus.ready:
                return _HistoryListView(
                  entries: state.entries,
                  highestScore: state.highestScore,
                );
            }
          },
        ),
      ),
    );
  }
}

class _HistoryListView extends StatelessWidget {
  _HistoryListView({required this.entries, required this.highestScore});

  final List<QuizHistoryEntry> entries;
  final int highestScore;
  final DateFormat _dateFormat = DateFormat('dd MMM yyyy HH:mm');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            'Highest Score: $highestScore',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return ListTile(
                title: Text('${entry.score}/${entry.totalQuestions} correct'),
                subtitle: Text(
                  'Completed at: ${_dateFormat.format(entry.createdAt.toLocal())}',
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: () {
              context.read<HistoryCubit>().clearHistory();
            },
            tooltip: 'Clear History',
          ),
        ),
      ],
    );
  }
}
