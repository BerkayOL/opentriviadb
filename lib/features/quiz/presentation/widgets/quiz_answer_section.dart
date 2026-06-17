import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../domain/constants/quiz_api_values.dart';
import '../../domain/entities/quiz_question.dart';
import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';
import '../resolvers/answer_option_status_resolver.dart';
import 'answer_option_card.dart';
import 'boolean_answer_feedback.dart';
import 'boolean_answer_switch.dart';

class QuizAnswerSection extends StatelessWidget {
  const QuizAnswerSection({
    required this.question,
    required this.state,
    super.key,
  });

  final QuizQuestion question;
  final QuizState state;

  @override
  Widget build(BuildContext context) {
    if (question.type == QuizApiValues.boolean) {
      return Column(
        children: [
          BooleanAnswerSwitch(
            falseStatus: resolveAnswerStatus(
              state: state,
              answer: AppStrings.falseAnswer,
              correctAnswer: question.correctAnswer,
            ),
            trueStatus: resolveAnswerStatus(
              state: state,
              answer: AppStrings.trueAnswer,
              correctAnswer: question.correctAnswer,
            ),
            onFalseTap: () => _selectAnswer(context, AppStrings.falseAnswer),
            onTrueTap: () => _selectAnswer(context, AppStrings.trueAnswer),
          ),
          BooleanAnswerFeedback(state: state),
        ],
      );
    }

    return Column(
      children: question.answers.asMap().entries.map((entry) {
        final optionIndex = entry.key;
        final answer = entry.value;

        return AnswerOptionCard(
          answer: answer,
          optionIndex: optionIndex,
          status: resolveAnswerStatus(
            state: state,
            answer: answer,
            correctAnswer: question.correctAnswer,
          ),
          onTap: () => _selectAnswer(context, answer),
        );
      }).toList(),
    );
  }

  void _selectAnswer(BuildContext context, String answer) {
    if (state.status == QuizStatus.answerRevealed) {
      return;
    }

    context.read<QuizCubit>().selectAnswer(answer);
  }
}
