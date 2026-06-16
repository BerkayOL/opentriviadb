import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../constants/quiz_dimensions.dart';
import '../../constants/quiz_setup_options.dart';
import '../../cubits/quiz_setup_cubit.dart';
import '../../cubits/quiz_setup_state.dart';
import 'quiz_setup_dropdown_decoration.dart';
import '../../theme/quiz_setup_palette.dart';

class DifficultySelector extends StatelessWidget {
  const DifficultySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSetupCubit, QuizSetupState>(
      builder: (context, state) {
        return DropdownButtonFormField<String?>(
          menuMaxHeight: QuizDimensions.dropdownMenuMaxHeight,
          dropdownColor: QuizSetupPalette.dropdownColor(context),
          iconEnabledColor: QuizSetupPalette.secondaryText(context),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: QuizSetupPalette.primaryText(context),
            fontWeight: FontWeight.w600,
          ),
          initialValue: state.selectedDifficulty,
          decoration: dropDownDecoration(context, AppStrings.anyLevel),
          borderRadius: BorderRadius.circular(AppRadius.md),
          isExpanded: true,
          itemHeight: QuizDimensions.dropdownItemHeight,
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
