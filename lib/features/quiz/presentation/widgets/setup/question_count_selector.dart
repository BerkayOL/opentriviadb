import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../constants/quiz_setup_options.dart';
import '../../cubits/quiz_setup_cubit.dart';
import '../../cubits/quiz_setup_state.dart';
import 'quiz_setup_dropdown_decoration.dart';
import '../../theme/quiz_setup_palette.dart';

class QuestionCountSelector extends StatelessWidget {
  const QuestionCountSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSetupCubit, QuizSetupState>(
      builder: (context, state) {
        return DropdownButtonFormField<int>(
          menuMaxHeight: 220,
          dropdownColor: QuizSetupPalette.dropdownColor(context),
          iconEnabledColor: QuizSetupPalette.secondaryText(context),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: QuizSetupPalette.primaryText(context),
            fontWeight: FontWeight.w600,
          ),
          initialValue: state.questionCount,
          decoration: dropDownDecoration(
            context,
            AppStrings.selectQuestionCount,
          ),
          itemHeight: 56,
          borderRadius: BorderRadius.circular(16),
          isExpanded: true,
          items: QuizSetupOptions.questionCounts
              .map(
                (count) => DropdownMenuItem<int>(
                  value: count,
                  child: Text(count.toString()),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            context.read<QuizSetupCubit>().selectQuestionCount(value);
          },
        );
      },
    );
  }
}
