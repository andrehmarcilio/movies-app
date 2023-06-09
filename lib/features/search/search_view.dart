import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/movie.dart';
import '../../support/components/movie_poster_card.dart';
import '../../support/components/svg_image.dart';
import '../../support/extensions/context_extensions.dart';
import '../../support/injector/app_injector.dart';
import '../../support/style/app_assets.dart';
import '../../support/utils/debouncer.dart';
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
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  @override
  void dispose() {
    viewModel.dispose();
    debouncer.dispose();
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
              controller: searchBarController,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onChanged: (value) {
                debouncer.run(() {
                  if (value.isNotEmpty) {
                    viewModel.searchMovies(query: value);
                  }
                });
              },
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
      SearchMoviesInitialState() => const _SearchInitialView(),
      SearchMoviesLoading() => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
      SearchMoviesEmpty() => const _SearchEmptyView(),
      SearchMoviesError(:final apiError) => SliverToBoxAdapter(child: Text(apiError.getErrorMessage(context.l10n))),
      SearchMoviesSuccess(:final movies) => _MoviesGridView(movies: movies),
    };
  }
}

class _SearchInitialView extends StatelessWidget {
  const _SearchInitialView();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Expanded(
            child: SvgImage(
              svgPath: AppAssets.icSearchMovie,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onBackground.withOpacity(.8),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              context.l10n.searchMoviesInitialPhraseLabel,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _SearchEmptyView extends StatelessWidget {
  const _SearchEmptyView();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Expanded(
            child: SvgImage(
              svgPath: AppAssets.icSearchEmpty,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onBackground.withOpacity(.8),
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              context.l10n.searchMoviesEmptyPhraseLabel,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
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
