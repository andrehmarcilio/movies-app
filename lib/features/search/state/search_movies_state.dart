import '../../../../models/movie.dart';
import '../../../../support/exceptions/api_exception.dart';

sealed class SearchMoviesState {}

class SearchMoviesInitialState extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesEmpty extends SearchMoviesState {}

class SearchMoviesSuccess extends SearchMoviesState {
  List<Movie> movies;

  SearchMoviesSuccess(this.movies);
}

class SearchMoviesError extends SearchMoviesState {
  ApiException apiError;

  SearchMoviesError(this.apiError);
}
