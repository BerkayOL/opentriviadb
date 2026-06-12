import 'package:equatable/equatable.dart';

import '../../domain/entities/quiz_category.dart';

enum QuizSetupStatus { initial, loading, ready, failure }

class QuizSetupState extends Equatable {
  const QuizSetupState({
    this.status = QuizSetupStatus.initial,
    this.categories = const [],
    this.selectedCategory,
    this.selectedDifficulty,
    this.questionCount = 10,
    this.questionType = 'multiple',
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
    QuizCategory? selectedCategory,
    String? selectedDifficulty,
    int? questionCount,
    String? questionType,
    String? errorMessage,
  }) {
    return QuizSetupState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedDifficulty: selectedDifficulty ?? this.selectedDifficulty,
      questionCount: questionCount ?? this.questionCount,
      questionType: questionType ?? this.questionType,
      errorMessage: errorMessage ?? this.errorMessage,
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
