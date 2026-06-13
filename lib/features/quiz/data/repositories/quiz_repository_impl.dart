import '../../../../core/error/app_exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/quiz_category.dart';
import '../../domain/entities/quiz_question.dart';
import '../../domain/entities/quiz_request.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/quiz_remote_datasource.dart';

class QuizRepositoryImpl implements QuizRepository {
  const QuizRepositoryImpl({required QuizRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final QuizRemoteDataSource _remoteDataSource;

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
    try {
      final models = await _remoteDataSource.fetchQuestions(request);
      return models.map((model) => model.toEntity()).toList();
    } on AppException catch (error) {
      throw _mapExceptionToFailure(error);
    } catch (_) {
      throw const UnknownFailure('An unexpected error occurred.');
    }
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
