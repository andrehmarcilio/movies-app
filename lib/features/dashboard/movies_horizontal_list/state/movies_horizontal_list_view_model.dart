import 'package:flutter/material.dart';

import '../../../../support/enums/movie_category.dart';
import '../../use_cases/get_movies_use_case.dart';
import 'movies_horizontal_list_state.dart';

class MoviesHorizontalListViewModel extends ValueNotifier<MoviesHorizontalListState> {
  final GetMoviesUseCase getMoviesUseCase;

  MoviesHorizontalListViewModel({required this.getMoviesUseCase}) : super(MoviesInitialState());

  Future<void> getMovies({required MovieCategory movieCategory}) async {
    value = MoviesLoading();

    final moviesResult = await getMoviesUseCase(movieCategory: movieCategory);
    moviesResult.fold(
      success: (movies) {
        value = MoviesSuccess(movies);
      },
      failure: (error) {
        value = MoviesError(error);
      },
    );
  }
}
