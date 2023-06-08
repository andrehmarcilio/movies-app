import '../../../../models/movie.dart';
import '../../../../support/exceptions/base_exception.dart';

sealed class MoviesHorizontalListState {}

class MoviesInitialState extends MoviesHorizontalListState {}

class MoviesLoading extends MoviesHorizontalListState {}

class MoviesSuccess extends MoviesHorizontalListState {
  List<Movie> movies;

  MoviesSuccess(this.movies);
}

class MoviesError extends MoviesHorizontalListState {
  BaseException error;

  MoviesError(this.error);
}
