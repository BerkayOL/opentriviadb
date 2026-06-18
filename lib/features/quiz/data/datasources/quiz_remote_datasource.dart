import 'package:dio/dio.dart';

import '../../../../core/error/app_exception.dart';
import '../../domain/entities/quiz_request.dart';
import '../constants/open_trivia_api_constants.dart';
import '../constants/quiz_data_error_messages.dart';
import '../mappers/open_trivia_dio_exception_mapper.dart';
import '../mappers/quiz_request_query_mapper.dart';
import '../models/quiz_category_model.dart';
import '../models/quiz_question_model.dart';
import '../parsers/open_trivia_response_parser.dart';

abstract interface class QuizRemoteDataSource {
  Future<List<QuizCategoryModel>> fetchCategories();

  Future<List<QuizQuestionModel>> fetchQuestions(QuizRequest request);
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  const QuizRemoteDataSourceImpl(
    this._dio, {
    OpenTriviaResponseParser responseParser = const OpenTriviaResponseParser(),
    QuizRequestQueryMapper queryMapper = const QuizRequestQueryMapper(),
    OpenTriviaDioExceptionMapper exceptionMapper =
        const OpenTriviaDioExceptionMapper(),
  }) : _responseParser = responseParser,
       _queryMapper = queryMapper,
       _exceptionMapper = exceptionMapper;

  final Dio _dio;
  final OpenTriviaResponseParser _responseParser;
  final QuizRequestQueryMapper _queryMapper;
  final OpenTriviaDioExceptionMapper _exceptionMapper;

  @override
  Future<List<QuizCategoryModel>> fetchCategories() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        OpenTriviaApiConstants.categoriesEndpoint,
      );
      return _responseParser.parseCategories(response.data);
    } on DioException catch (error) {
      _exceptionMapper.throwMapped(error, OpenTriviaRequestType.category);
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
        queryParameters: _queryMapper.toQueryParameters(request),
      );
      return _responseParser.parseQuestions(response.data);
    } on DioException catch (error) {
      _exceptionMapper.throwMapped(error, OpenTriviaRequestType.question);
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
}
