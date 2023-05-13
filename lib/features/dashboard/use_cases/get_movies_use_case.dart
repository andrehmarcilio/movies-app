import 'dart:async';

import '../../../data/remote/routes/movies_routes.dart';
import '../../../models/movie.dart';
import '../../../support/enums/movie_category.dart';
import '../../../support/exceptions/api_exception.dart';
import '../../../support/utils/either.dart';

typedef MovieResponse = FutureOr<Either<ApiException, List<Movie>>>;

abstract interface class GetMoviesUseCase {
  MovieResponse call({required MovieCategory movieCategory});
}

class GetMoviesUseCaseImpl implements GetMoviesUseCase {
  final MoviesRoutes moviesRoutes;

  GetMoviesUseCaseImpl({required this.moviesRoutes});

  @override
  MovieResponse call({required MovieCategory movieCategory}) async {
    final apiResult = await moviesRoutes.getMovies(movieCategory: movieCategory);
    if (apiResult.isSuccess) {
      final moviesList = Movie.fromList(apiResult.successData['results']);
      return Success(moviesList);
    }

    return Failure(apiResult.failureData);
  }
}
