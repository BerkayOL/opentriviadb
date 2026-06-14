import '../../../../core/constants/app_strings.dart';
import '../../domain/constants/quiz_api_values.dart';

class QuizSetupOption<T> {
  const QuizSetupOption({required this.label, required this.value});

  final String label;
  final T value;
}

abstract final class QuizSetupOptions {
  static const List<int> questionCounts = [5, 10, 15, 20];

  static const List<QuizSetupOption<String?>> difficulties = [
    QuizSetupOption(label: AppStrings.anyLevel, value: null),
    QuizSetupOption(label: AppStrings.easy, value: QuizApiValues.easy),
    QuizSetupOption(label: AppStrings.medium, value: QuizApiValues.medium),
    QuizSetupOption(label: AppStrings.hard, value: QuizApiValues.hard),
  ];

  static const List<QuizSetupOption<String>> questionTypes = [
    QuizSetupOption(
      label: AppStrings.multipleChoice,
      value: QuizApiValues.multiple,
    ),
    QuizSetupOption(label: AppStrings.trueFalse, value: QuizApiValues.boolean),
  ];
}
