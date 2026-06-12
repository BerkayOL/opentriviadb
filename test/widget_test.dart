import 'package:flutter_test/flutter_test.dart';
import 'package:opentriviadb/app/app.dart';
import 'package:opentriviadb/app/dependency_injection/app_di.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_category.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_question.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_request.dart';
import 'package:opentriviadb/features/quiz/domain/entities/quiz_result.dart';
import 'package:opentriviadb/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:opentriviadb/features/quiz/domain/usecases/get_categories_usecase.dart';
import 'package:opentriviadb/features/quiz/presentation/cubits/quiz_setup_cubit.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    getIt.registerFactory<QuizSetupCubit>(
      () => QuizSetupCubit(GetCategoriesUseCase(_FakeQuizRepository())),
    );
  });

  testWidgets('shows quiz setup page', (WidgetTester tester) async {
    await tester.pumpWidget(const TriviaQuizApp());
    await tester.pumpAndSettle();

    expect(find.text('Trivia Quiz'), findsWidgets);
    expect(find.text('General Knowledge'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);
  });
}

class _FakeQuizRepository implements QuizRepository {
  @override
  Future<List<QuizCategory>> getCategories() async {
    return const [QuizCategory(id: 9, name: 'General Knowledge')];
  }

  @override
  Future<List<QuizQuestion>> getQuestions(QuizRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveQuizResult(QuizResult result) {
    throw UnimplementedError();
  }
}
