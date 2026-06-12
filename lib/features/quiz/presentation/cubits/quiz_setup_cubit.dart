import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/quiz_category.dart';
import 'quiz_setup_state.dart';

class QuizSetupCubit extends Cubit<QuizSetupState> {
  QuizSetupCubit() : super(const QuizSetupState());

  Future<void> loadCategories() async {
    // TODO: Load categories through GetCategoriesUseCase.
    emit(state.copyWith(status: QuizSetupStatus.ready));
  }

  void selectCategory(QuizCategory category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void selectDifficulty(String? difficulty) {
    emit(state.copyWith(selectedDifficulty: difficulty));
  }

  void selectQuestionCount(int count) {
    emit(state.copyWith(questionCount: count));
  }

  void selectType(String type) {
    emit(state.copyWith(questionType: type));
  }
}
