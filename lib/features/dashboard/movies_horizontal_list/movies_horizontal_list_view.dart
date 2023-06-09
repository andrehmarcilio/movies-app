import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../../support/components/movie_poster_card.dart';
import '../../../support/enums/movie_category.dart';
import '../../../support/extensions/context_extensions.dart';
import '../../../support/injector/app_injector.dart';
import 'state/movies_horizontal_list_state.dart';
import 'state/movies_horizontal_list_view_model.dart';

class MoviesHorizontalListView extends StatefulWidget {
  final MovieCategory movieCategory;

  const MoviesHorizontalListView({required this.movieCategory, super.key});

  @override
  State<MoviesHorizontalListView> createState() => _MoviesHorizontalListViewState();
}

class _MoviesHorizontalListViewState extends State<MoviesHorizontalListView> with AutomaticKeepAliveClientMixin {
  final viewModel = AppInjector.get<MoviesHorizontalListViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.getMovies(movieCategory: widget.movieCategory);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            widget.movieCategory.getSectionTitle(context.l10n),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 232,
          child: ValueListenableBuilder(
            valueListenable: viewModel,
            builder: _getMoviesListByState,
          ),
        ),
      ],
    );
  }

  Widget _getMoviesListByState(BuildContext context, MoviesHorizontalListState state, Widget? child) {
    return switch (state) {
      MoviesInitialState() || MoviesLoading() => const Center(child: CircularProgressIndicator()),
      MoviesError(error: final apiError) => Text(apiError.getErrorMessage(context.l10n)),
      MoviesSuccess(:final movies) => _MoviesHorizontalList(movies: movies),
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _MoviesHorizontalList extends StatelessWidget {
  final List<Movie> movies;

  const _MoviesHorizontalList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (_, index) {
        final movie = movies[index];
        return Padding(
          padding: const EdgeInsets.only(left: 8),
          child: MoviePosterCard(movie: movie),
        );
      },
    );
  }
}
