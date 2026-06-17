import 'package:dio/dio.dart';

import '../../../../core/error/app_exception.dart';
import '../../domain/entities/quiz_request.dart';
import '../constants/open_trivia_api_constants.dart';
import '../constants/quiz_data_error_messages.dart';
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
        OpenTriviaApiConstants.categoriesEndpoint,
      );
      return _parseCategories(response.data);
    } on DioException catch (error) {
      _throwMappedDioException(error, _QuizRequestContext.category);
    } on AppException {
      rethrow;
    } on FormatException catch (error) {
      throw ServerException(error.message);
    } on TypeError {
      throw const ServerException(
        QuizDataErrorMessages.categoryResponseContainsInvalidData,
      );
    }
  }

  @override
  Future<List<QuizQuestionModel>> fetchQuestions(QuizRequest request) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        OpenTriviaApiConstants.questionsEndpoint,
        queryParameters: _questionQueryParameters(request),
      );
      return _parseQuestions(response.data);
    } on DioException catch (error) {
      _throwMappedDioException(error, _QuizRequestContext.question);
    } on AppException {
      rethrow;
    } on FormatException catch (error) {
      throw ServerException(error.message);
    } on TypeError {
      throw const ServerException(
        QuizDataErrorMessages.questionResponseContainsInvalidData,
      );
    }
  }

  List<QuizCategoryModel> _parseCategories(Map<String, dynamic>? data) {
    final categoriesJson =
        data?[OpenTriviaApiConstants.responseTriviaCategories];

    if (categoriesJson is! List) {
      throw const ServerException(
        QuizDataErrorMessages.categoryResponseFormatInvalid,
      );
    }

    final categories = categoriesJson
        .map((json) => QuizCategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();

    if (categories.isEmpty) {
      throw const EmptyResultException(QuizDataErrorMessages.noCategoriesFound);
    }

    return categories;
  }

  List<QuizQuestionModel> _parseQuestions(Map<String, dynamic>? data) {
    final responseCode = data?[OpenTriviaApiConstants.responseCode];
    final resultsJson = data?[OpenTriviaApiConstants.responseResults];

    if (responseCode is! num || resultsJson is! List) {
      throw const ServerException(
        QuizDataErrorMessages.questionResponseFormatInvalid,
      );
    }

    final code = responseCode.toInt();
    if (code == OpenTriviaApiConstants.noResultsResponseCode ||
        resultsJson.isEmpty) {
      throw const EmptyResultException(QuizDataErrorMessages.noQuestionsFound);
    }

    if (code != OpenTriviaApiConstants.successResponseCode) {
      throw ServerException(
        QuizDataErrorMessages.questionRequestFailedWithResponseCode(code),
      );
    }

    return resultsJson
        .map((json) => QuizQuestionModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Never _throwMappedDioException(
    DioException error,
    _QuizRequestContext context,
  ) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      throw const NetworkException(
        QuizDataErrorMessages.checkInternetConnection,
      );
    }

    final statusCode =
        error.response?.statusCode ?? QuizDataErrorMessages.unknownStatusCode;

    throw ServerException(switch (context) {
      _QuizRequestContext.category =>
        QuizDataErrorMessages.categoryRequestFailedWithStatus(statusCode),
      _QuizRequestContext.question =>
        QuizDataErrorMessages.questionRequestFailedWithStatus(statusCode),
    });
  }

  Map<String, dynamic> _questionQueryParameters(QuizRequest request) {
    return {
      OpenTriviaApiConstants.queryAmount: request.amount,
      if (request.categoryId != null)
        OpenTriviaApiConstants.queryCategory: request.categoryId,
      if (request.difficulty != null && request.difficulty!.isNotEmpty)
        OpenTriviaApiConstants.queryDifficulty: request.difficulty,
      OpenTriviaApiConstants.queryType: request.type,
    };
  }
}

enum _QuizRequestContext { category, question }
