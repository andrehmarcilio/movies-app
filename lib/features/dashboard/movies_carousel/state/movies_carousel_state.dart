import '../../../../models/movie.dart';
import '../../../../support/exceptions/base_exception.dart';

sealed class MoviesCarouselState {}

class MoviesCarouselInitialState extends MoviesCarouselState {}

class MoviesCarouselLoading extends MoviesCarouselState {}

class MoviesCarouselSuccess extends MoviesCarouselState {
  List<Movie> movies;

  MoviesCarouselSuccess(this.movies);
}

class MoviesCarouselError extends MoviesCarouselState {
  BaseException error;

  MoviesCarouselError(this.error);
}
