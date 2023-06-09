import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../support/exceptions/api_exception.dart';
import '../../../support/utils/either.dart';
import 'api_host.dart';
import 'end_point.dart';

typedef ApiResult = FutureOr<Either<ApiException, dynamic>>;

abstract class HttpClient {
  ApiResult request({required Endpoint endpoint});
}

class DioClient extends HttpClient {
  late final Dio _dio;

  DioClient({Dio? dio}) {
    final baseOptions = BaseOptions(baseUrl: ApiHost.baseURL);

    _dio = dio ?? Dio(baseOptions);
  }

  @override
  ApiResult request({required Endpoint endpoint}) async {
    try {
      final requestOptions = Options(
        method: endpoint.method.name,
        contentType: endpoint.contentType ?? ContentType.json.value,
      );

      final response = await _dio.request(
        endpoint.path,
        data: endpoint.data,
        options: requestOptions,
        queryParameters: endpoint.queryParameters,
      );

      return Success(response.data);
    } on DioError catch (dioError) {
      return Failure(
        ApiException(
          message: dioError.message,
          statusCode: dioError.response?.statusCode,
        ),
      );
    }
  }
}
