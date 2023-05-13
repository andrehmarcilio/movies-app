import '../../../../models/movie.dart';
import '../../../../support/exceptions/api_exception.dart';

sealed class MoviesHorizontalListState {}

class MoviesInitialState extends MoviesHorizontalListState {}

class MoviesLoading extends MoviesHorizontalListState {}

class MoviesSuccess extends MoviesHorizontalListState {
  List<Movie> movies;

  MoviesSuccess(this.movies);
}

class MoviesError extends MoviesHorizontalListState {
  ApiException apiError;

  MoviesError(this.apiError);
}
