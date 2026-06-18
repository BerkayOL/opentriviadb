import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../domain/entities/quiz_request.dart';
import '../../constants/quiz_dimensions.dart';
import '../../cubits/quiz_setup_cubit.dart';
import '../../cubits/quiz_setup_state.dart';
import '../../theme/quiz_setup_palette.dart';

class StartQuizButton extends StatelessWidget {
  const StartQuizButton({required this.onStart, super.key});

  final ValueChanged<QuizRequest> onStart;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizSetupCubit, QuizSetupState>(
      builder: (context, state) {
        final isReady = state.status == QuizSetupStatus.ready;
        return Opacity(
          opacity: isReady
              ? QuizDimensions.maximumProgress
              : QuizDimensions.quizStartDisabledOpacity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: QuizSetupPalette.startButtonGradient,
              ),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: [
                BoxShadow(
                  blurRadius: QuizDimensions.quizStartShadowBlur,
                  offset: const Offset(
                    0,
                    QuizDimensions.quizStartShadowOffsetY,
                  ),
                  color: QuizSetupPalette.startButtonShadow(),
                ),
              ],
            ),
            child: FilledButton.icon(
              onPressed: isReady
                  ? () {
                      final request = QuizRequest(
                        amount: state.questionCount,
                        categoryId: state.selectedCategory?.id,
                        difficulty: state.selectedDifficulty,
                        type: state.questionType,
                      );
                      onStart(request);
                    }
                  : null,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text(AppStrings.startQuiz),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(
                  QuizDimensions.quizStartButtonHeight,
                ),
                backgroundColor: QuizSetupPalette.transparent,
                disabledBackgroundColor: QuizSetupPalette.transparent,
                shadowColor: QuizSetupPalette.transparent,
                foregroundColor: QuizSetupPalette.startButtonForeground,
                disabledForegroundColor: QuizSetupPalette.startButtonForeground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: QuizDimensions.setupStartButtonLetterSpacing,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
