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
      final data = response.data;
      final categoriesJson =
          data?[OpenTriviaApiConstants.responseTriviaCategories];

      if (categoriesJson is! List) {
        throw const ServerException(
          QuizDataErrorMessages.categoryResponseFormatInvalid,
        );
      }

      final categories = categoriesJson
          .map(
            (json) => QuizCategoryModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      if (categories.isEmpty) {
        throw const EmptyResultException(
          QuizDataErrorMessages.noCategoriesFound,
        );
      }

      return categories;
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        throw const NetworkException(
          QuizDataErrorMessages.checkInternetConnection,
        );
      }

      throw ServerException(
        QuizDataErrorMessages.categoryRequestFailedWithStatus(
          error.response?.statusCode ?? QuizDataErrorMessages.unknownStatusCode,
        ),
      );
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
      final data = response.data;
      final responseCode = data?[OpenTriviaApiConstants.responseCode];
      final resultsJson = data?[OpenTriviaApiConstants.responseResults];

      if (responseCode is! num || resultsJson is! List) {
        throw const ServerException(
          QuizDataErrorMessages.questionResponseFormatInvalid,
        );
      }

      if (responseCode.toInt() ==
              OpenTriviaApiConstants.noResultsResponseCode ||
          resultsJson.isEmpty) {
        throw const EmptyResultException(
          QuizDataErrorMessages.noQuestionsFound,
        );
      }

      if (responseCode.toInt() != OpenTriviaApiConstants.successResponseCode) {
        throw ServerException(
          QuizDataErrorMessages.questionRequestFailedWithResponseCode(
            responseCode.toInt(),
          ),
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
        throw const NetworkException(
          QuizDataErrorMessages.checkInternetConnection,
        );
      }

      throw ServerException(
        QuizDataErrorMessages.questionRequestFailedWithStatus(
          error.response?.statusCode ?? QuizDataErrorMessages.unknownStatusCode,
        ),
      );
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
