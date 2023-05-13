import '../enums/http_method.dart';
import 'api_host.dart';

class Endpoint {
  final String path;
  final dynamic data;
  final HttpMethod method;
  final String? contentType;
  final Map<String, String> _queryParameters = ApiHost.defaultQueryParams;

  set queryParameters(Map<String, String> params) {
    _queryParameters.addAll(params);
  }

  Map<String, String> get queryParameters {
    return _queryParameters;
  }

  Endpoint({
    required this.path,
    required this.method,
    this.data,
    this.contentType,
    Map<String, String>? queryParameters,
  }) {
    if (queryParameters != null) {
      this.queryParameters = queryParameters;
    }
  }
}
