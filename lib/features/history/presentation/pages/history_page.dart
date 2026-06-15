import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubits/history_cubit.dart';
import '../cubits/history_state.dart';
import '../theme/history_palette.dart';
import '../widgets/history_body.dart';
import '../widgets/history_header.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: HistoryPalette.backgroundGradient(context),
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                return ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    128,
                  ),
                  children: [
                    const HistoryHeader(),
                    const SizedBox(height: AppSpacing.xl),
                    HistoryBody(state: state),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
