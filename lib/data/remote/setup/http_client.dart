import 'dart:async';

import '../../../utils/either.dart';
import '../../../utils/exceptions/api_exception.dart';
import 'end_point.dart';

typedef ApiResult = FutureOr<Either<ApiException, dynamic>>;

abstract class HttpClient {
  ApiResult get({required Endpoint endpoint});
  ApiResult post({required Endpoint endpoint});
  ApiResult put({required Endpoint endpoint});
  ApiResult delete({required Endpoint endpoint});
}
