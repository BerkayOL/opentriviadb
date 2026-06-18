import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opentriviadb/core/error/app_exception.dart';
import 'package:opentriviadb/features/quiz/data/mappers/open_trivia_dio_exception_mapper.dart';

void main() {
  const mapper = OpenTriviaDioExceptionMapper();

  test('maps connection failures to NetworkException', () {
    final error = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );

    expect(
      () => mapper.throwMapped(error, OpenTriviaRequestType.question),
      throwsA(isA<NetworkException>()),
    );
  });

  test('maps response failures with request-specific context', () {
    final requestOptions = RequestOptions();
    final error = DioException(
      requestOptions: requestOptions,
      response: Response<dynamic>(
        requestOptions: requestOptions,
        statusCode: 503,
      ),
      type: DioExceptionType.badResponse,
    );

    expect(
      () => mapper.throwMapped(error, OpenTriviaRequestType.category),
      throwsA(
        isA<ServerException>().having(
          (exception) => exception.message,
          'message',
          contains('Category request failed'),
        ),
      ),
    );
  });
}
