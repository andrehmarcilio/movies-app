import 'package:flutter/material.dart';

import '../use_cases/search_movies_use_case.dart';
import 'search_movies_state.dart';

class SearchMoviesViewModel extends ValueNotifier<SearchMoviesState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  SearchMoviesViewModel({required this.searchMoviesUseCase}) : super(SearchMoviesInitialState());

  Future<void> searchMovies({required String query}) async {
    value = SearchMoviesLoading();

    final moviesResult = await searchMoviesUseCase(query: query);
    moviesResult.fold(
      success: (movies) {
        value = SearchMoviesSuccess(movies);
      },
      failure: (error) {
        value = SearchMoviesError(error);
      },
    );
  }
}
