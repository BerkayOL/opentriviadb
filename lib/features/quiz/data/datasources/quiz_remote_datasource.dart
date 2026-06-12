import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/app_exception.dart';
import '../../domain/entities/quiz_request.dart';
import '../models/quiz_category_model.dart';
import '../models/quiz_question_model.dart';

abstract interface class QuizRemoteDataSource {
  Future<List<QuizCategoryModel>> fetchCategories();

  Future<List<QuizQuestionModel>> fetchQuestions(QuizRequest request);
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  const QuizRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<QuizCategoryModel>> fetchCategories() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.categoriesEndpoint,
      );
      final data = response.data;
      final categoriesJson = data?['trivia_categories'];

      if (categoriesJson is! List) {
        throw const ServerException('Category response format is invalid.');
      }

      final categories = categoriesJson
          .map(
            (json) => QuizCategoryModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      if (categories.isEmpty) {
        throw const EmptyResultException('No categories found.');
      }

      return categories;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        throw const NetworkException('Check your internet connection.');
      }

      throw ServerException(
        'Category request failed with status ${error.response?.statusCode ?? 'unknown'}.',
      );
    } on AppException {
      rethrow;
    } on FormatException catch (error) {
      throw ServerException(error.message);
    } on TypeError {
      throw const ServerException('Category response contains invalid data.');
    }
  }

  @override
  Future<List<QuizQuestionModel>> fetchQuestions(QuizRequest request) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiConstants.questionsEndpoint,
        queryParameters: _questionQueryParameters(request),
      );
      final data = response.data;
      final responseCode = data?['response_code'];
      final resultsJson = data?['results'];

      if (responseCode is! num || resultsJson is! List) {
        throw const ServerException('Question response format is invalid.');
      }

      if (responseCode.toInt() == 1 || resultsJson.isEmpty) {
        throw const EmptyResultException('No questions found.');
      }

      if (responseCode.toInt() != 0) {
        throw ServerException(
          'Question request failed with response code ${responseCode.toInt()}.',
        );
      }

      return resultsJson
          .map(
            (json) => QuizQuestionModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        throw const NetworkException('Check your internet connection.');
      }

      throw ServerException(
        'Question request failed with status ${error.response?.statusCode ?? 'unknown'}.',
      );
    } on AppException {
      rethrow;
    } on FormatException catch (error) {
      throw ServerException(error.message);
    } on TypeError {
      throw const ServerException('Question response contains invalid data.');
    }
  }

  Map<String, dynamic> _questionQueryParameters(QuizRequest request) {
    return {
      'amount': request.amount,
      if (request.categoryId != null) 'category': request.categoryId,
      if (request.difficulty != null && request.difficulty!.isNotEmpty)
        'difficulty': request.difficulty,
      'type': request.type,
    };
  }
}
