import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../../support/components/movie_poster_card.dart';
import '../../../support/enums/movie_category.dart';
import '../../../support/extensions/context_extensions.dart';
import '../../../support/injector/app_injector.dart';
import 'cubit/movies_horizontal_list_cubit.dart';
import 'cubit/movies_horizontal_list_state.dart';

class MoviesHorizontalListView extends StatefulWidget {
  final MovieCategory movieCategory;

  const MoviesHorizontalListView({required this.movieCategory, super.key});

  @override
  State<MoviesHorizontalListView> createState() => _MoviesHorizontalListViewState();
}

class _MoviesHorizontalListViewState extends State<MoviesHorizontalListView> with AutomaticKeepAliveClientMixin {
  final cubit = AppInjector.get<MoviesHorizontalListCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getMovies(movieCategory: widget.movieCategory);
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
            valueListenable: cubit,
            builder: _getMoviesListByState,
          ),
        ),
      ],
    );
  }

  Widget _getMoviesListByState(BuildContext context, MoviesHorizontalListState state, Widget? child) {
    return switch (state) {
      MoviesInitialState() || MoviesLoading() => const Center(child: CircularProgressIndicator()),
      MoviesError() => Text(state.apiError.getErrorMessage(context.l10n)),
      MoviesSuccess() => _MoviesHorizontalList(movies: state.movies),
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
