import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/quiz_category.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import 'quiz_setup_state.dart';

class QuizSetupCubit extends Cubit<QuizSetupState> {
  QuizSetupCubit(this._getCategoriesUseCase) : super(const QuizSetupState());

  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> loadCategories() async {
    emit(
      state.copyWith(
        status: QuizSetupStatus.loading,
        categories: const [],
        selectedCategory: null,
        errorMessage: null,
      ),
    );

    try {
      final categories = await _getCategoriesUseCase();
      emit(
        state.copyWith(
          status: QuizSetupStatus.ready,
          categories: categories,
          selectedCategory: categories.isEmpty ? null : categories.first,
          errorMessage: null,
        ),
      );
    } on EmptyResultFailure {
      emit(
        state.copyWith(
          status: QuizSetupStatus.ready,
          categories: const [],
          selectedCategory: null,
          errorMessage: null,
        ),
      );
    } on Failure catch (failure) {
      emit(
        state.copyWith(
          status: QuizSetupStatus.failure,
          errorMessage: failure.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: QuizSetupStatus.failure,
          errorMessage: 'Categories could not be loaded.',
        ),
      );
    }
  }

  void selectCategory(QuizCategory? category) {
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
