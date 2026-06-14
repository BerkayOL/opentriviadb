import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../constants/quiz_setup_options.dart';
import '../../cubits/quiz_setup_cubit.dart';
import '../../cubits/quiz_setup_state.dart';
import 'quiz_setup_dropdown_decoration.dart';

class QuestionTypeSelector extends StatelessWidget {
  const QuestionTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSetupCubit, QuizSetupState>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          initialValue: state.questionType,
          decoration: dropDownDecoration(
            context,
            AppStrings.selectQuestionType,
          ),
          borderRadius: BorderRadius.circular(16),
          isExpanded: true,
          items: QuizSetupOptions.questionTypes
              .map(
                (option) => DropdownMenuItem<String>(
                  value: option.value,
                  child: Text(option.label),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            context.read<QuizSetupCubit>().selectType(value);
          },
        );
      },
    );
  }
}
