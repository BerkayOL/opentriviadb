import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../constants/quiz_setup_options.dart';
import '../../cubits/quiz_setup_cubit.dart';
import '../../cubits/quiz_setup_state.dart';
import 'quiz_setup_dropdown_decoration.dart';

class DifficultySelector extends StatelessWidget {
  const DifficultySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSetupCubit, QuizSetupState>(
      builder: (context, state) {
        return DropdownButtonFormField<String?>(
          initialValue: state.selectedDifficulty,
          decoration: dropDownDecoration(context, AppStrings.anyLevel),
          borderRadius: BorderRadius.circular(16),
          isExpanded: true,
          items: QuizSetupOptions.difficulties
              .map(
                (option) => DropdownMenuItem<String?>(
                  value: option.value,
                  child: Text(option.label),
                ),
              )
              .toList(),
          onChanged: context.read<QuizSetupCubit>().selectDifficulty,
        );
      },
    );
  }
}
