import '../../../support/enums/movie_category.dart';
import '../enums/http_method.dart';
import '../setup/end_point.dart';
import '../setup/http_client.dart';

abstract interface class MoviesRoutes {
  ApiResult getMovies({required MovieCategory movieCategory});
}

class MoviesRoutesImpl implements MoviesRoutes {
  final HttpClient client;

  MoviesRoutesImpl(this.client);

  @override
  ApiResult getMovies({required MovieCategory movieCategory}) async {
    final endpoint = Endpoint(path: '/movie/${movieCategory.path}', method: HttpMethod.get);

    return await client.request(endpoint: endpoint);
  }
}
