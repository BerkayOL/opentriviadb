import '../entities/quiz_category.dart';
import '../repositories/quiz_repository.dart';

class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);

  final QuizRepository _repository;

  Future<List<QuizCategory>> call() => _repository.getCategories();
}
