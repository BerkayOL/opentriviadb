import 'package:equatable/equatable.dart';

import '../../domain/constants/quiz_api_values.dart';
import '../../domain/constants/quiz_config.dart';
import '../../domain/entities/quiz_category.dart';

enum QuizSetupStatus { initial, loading, ready, failure }

const Object _unset = Object();

class QuizSetupState extends Equatable {
  const QuizSetupState({
    this.status = QuizSetupStatus.initial,
    this.categories = const [],
    this.selectedCategory,
    this.selectedDifficulty,
    this.questionCount = QuizConfig.defaultQuestionAmount,
    this.questionType = QuizApiValues.multiple,
    this.errorMessage,
  });

  final QuizSetupStatus status;
  final List<QuizCategory> categories;
  final QuizCategory? selectedCategory;
  final String? selectedDifficulty;
  final int questionCount;
  final String questionType;
  final String? errorMessage;

  QuizSetupState copyWith({
    QuizSetupStatus? status,
    List<QuizCategory>? categories,
    Object? selectedCategory = _unset,
    Object? selectedDifficulty = _unset,
    int? questionCount,
    String? questionType,
    Object? errorMessage = _unset,
  }) {
    return QuizSetupState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategory: identical(selectedCategory, _unset)
          ? this.selectedCategory
          : selectedCategory as QuizCategory?,
      selectedDifficulty: identical(selectedDifficulty, _unset)
          ? this.selectedDifficulty
          : selectedDifficulty as String?,
      questionCount: questionCount ?? this.questionCount,
      questionType: questionType ?? this.questionType,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    status,
    categories,
    selectedCategory,
    selectedDifficulty,
    questionCount,
    questionType,
    errorMessage,
  ];
}
