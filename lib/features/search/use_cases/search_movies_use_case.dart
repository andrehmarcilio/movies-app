import 'dart:async';

import '../../../data/remote/routes/movies_routes.dart';
import '../../../models/movie.dart';
import '../../../support/exceptions/api_exception.dart';
import '../../../support/utils/either.dart';

typedef MovieResponse = FutureOr<Either<ApiException, List<Movie>>>;

abstract interface class SearchMoviesUseCase {
  MovieResponse call({required String query});
}

class SearchMoviesUseCaseImpl implements SearchMoviesUseCase {
  final MoviesRoutes moviesRoutes;

  SearchMoviesUseCaseImpl({required this.moviesRoutes});

  @override
  MovieResponse call({required String query}) async {
    final apiResult = await moviesRoutes.searchMovies(query: query);
    if (apiResult.isSuccess) {
      final moviesList = Movie.fromList(apiResult.successData['results']);
      return Success(moviesList);
    }

    return Failure(apiResult.failureData);
  }
}
