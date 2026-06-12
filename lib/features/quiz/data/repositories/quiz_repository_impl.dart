import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/quiz_category.dart';
import '../../domain/entities/quiz_question.dart';
import '../../domain/entities/quiz_request.dart';
import '../../domain/entities/quiz_result.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/quiz_local_datasource.dart';
import '../datasources/quiz_remote_datasource.dart';
import '../models/quiz_result_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  const QuizRepositoryImpl({
    required QuizRemoteDataSource remoteDataSource,
    required QuizLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final QuizRemoteDataSource _remoteDataSource;
  final QuizLocalDataSource _localDataSource;

  @override
  Future<List<QuizCategory>> getCategories() async {
    try {
      final models = await _remoteDataSource.fetchCategories();
      return models.map((model) => model.toEntity()).toList();
    } on AppException catch (error) {
      throw _mapExceptionToFailure(error);
    } catch (_) {
      throw const UnknownFailure('An unexpected error occurred.');
    }
  }

  @override
  Future<List<QuizQuestion>> getQuestions(QuizRequest request) async {
    final models = await _remoteDataSource.fetchQuestions(request);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveQuizResult(QuizResult result) {
    return _localDataSource.saveQuizResult(QuizResultModel.fromEntity(result));
  }

  Failure _mapExceptionToFailure(AppException exception) {
    return switch (exception) {
      NetworkException() => NetworkFailure(exception.message),
      ServerException() => ServerFailure(exception.message),
      EmptyResultException() => EmptyResultFailure(exception.message),
      LocalStorageException() => LocalStorageFailure(exception.message),
      _ => UnknownFailure(exception.message),
    };
  }
}
