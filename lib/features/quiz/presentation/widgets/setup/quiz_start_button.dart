import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../domain/entities/quiz_request.dart';
import '../../cubits/quiz_setup_cubit.dart';
import '../../cubits/quiz_setup_state.dart';

class StartQuizButton extends StatelessWidget {
  const StartQuizButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSetupCubit, QuizSetupState>(
      builder: (context, state) {
        return AppButton(
          label: AppStrings.startQuiz,
          icon: Icons.play_arrow_rounded,
          onPressed: state.status == QuizSetupStatus.ready
              ? () {
                  final request = QuizRequest(
                    amount: state.questionCount,
                    categoryId: state.selectedCategory?.id,
                    difficulty: state.selectedDifficulty,
                    type: state.questionType,
                  );
                  context.push(AppRoutes.quiz, extra: request);
                }
              : null,
        );
      },
    );
  }
}
