import 'package:flutter/material.dart';

import '../../../../support/enums/movie_category.dart';
import '../../use_cases/get_movies_use_case.dart';
import 'movies_carousel_state.dart';

class MoviesCarouselViewModel extends ValueNotifier<MoviesCarouselState> {
  final GetMoviesUseCase getMoviesUseCase;

  MoviesCarouselViewModel({required this.getMoviesUseCase}) : super(MoviesCarouselInitialState());

  Future<void> getMovies({required MovieCategory movieCategory}) async {
    value = MoviesCarouselLoading();

    final moviesResult = await getMoviesUseCase(movieCategory: movieCategory);
    moviesResult.fold(
      success: (movies) {
        value = MoviesCarouselSuccess(movies);
      },
      failure: (error) {
        value = MoviesCarouselError(error);
      },
    );
  }
}
