import 'package:dio/dio.dart';

import '../../../../core/error/app_exception.dart';
import '../constants/quiz_data_error_messages.dart';

enum OpenTriviaRequestType { category, question }

class OpenTriviaDioExceptionMapper {
  const OpenTriviaDioExceptionMapper();

  Never throwMapped(DioException error, OpenTriviaRequestType requestType) {
    if (_isNetworkFailure(error.type)) {
      throw const NetworkException(
        QuizDataErrorMessages.checkInternetConnection,
      );
    }

    final statusCode =
        error.response?.statusCode ?? QuizDataErrorMessages.unknownStatusCode;

    throw ServerException(switch (requestType) {
      OpenTriviaRequestType.category =>
        QuizDataErrorMessages.categoryRequestFailedWithStatus(statusCode),
      OpenTriviaRequestType.question =>
        QuizDataErrorMessages.questionRequestFailedWithStatus(statusCode),
    });
  }

  bool _isNetworkFailure(DioExceptionType type) {
    return type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.connectionError;
  }
}
