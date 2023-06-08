import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/movie.dart';
import '../../support/components/movie_poster_card.dart';
import '../../support/extensions/context_extensions.dart';
import '../../support/injector/app_injector.dart';
import 'state/search_movies_state.dart';
import 'state/search_movies_view_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchBarController = TextEditingController();
  final viewModel = AppInjector.get<SearchMoviesViewModel>();

  @override
  void dispose() {
    viewModel.dispose();
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            floating: true,
            toolbarHeight: 80,
            title: SearchBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () {
                    viewModel.searchMovies(query: searchBarController.text);
                  },
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              controller: searchBarController,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: viewModel,
            builder: _moviesGridWidget,
          ),
        ],
      ),
    );
  }

  Widget _moviesGridWidget(BuildContext context, SearchMoviesState state, Widget? child) {
    return switch (state) {
      SearchMoviesInitialState() => const SliverToBoxAdapter(),
      SearchMoviesLoading() => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
      SearchMoviesEmpty() => const SliverToBoxAdapter(),
      SearchMoviesError(:final apiError) => SliverToBoxAdapter(child: Text(apiError.getErrorMessage(context.l10n))),
      SearchMoviesSuccess(:final movies) => _MoviesGridView(movies: movies),
    };
  }
}

class _MoviesGridView extends StatelessWidget {
  final List<Movie> movies;

  const _MoviesGridView({required this.movies});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.2 / 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 8,
        ),
        itemCount: movies.length,
        itemBuilder: (_, index) {
          final movie = movies[index];

          return MoviePosterCard(movie: movie);
        },
      ),
    );
  }
}
