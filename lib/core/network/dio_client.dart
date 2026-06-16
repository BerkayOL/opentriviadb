import 'package:dio/dio.dart';

import '../constants/network_constants.dart';

class DioClient {
  DioClient();

  Dio create({required String baseUrl}) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: NetworkConstants.requestTimeout,
        receiveTimeout: NetworkConstants.requestTimeout,
      ),
    );
  }
}
