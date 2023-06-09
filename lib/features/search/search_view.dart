import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../support/components/placeholder/empty_placeholder.dart';
import '../../support/components/svg_image.dart';
import '../../support/extensions/context_extensions.dart';
import '../../support/injector/app_injector.dart';
import '../../support/style/app_assets.dart';
import '../../support/utils/debouncer.dart';
import 'components/movies_grid_widget.dart';
import 'components/search_initial_placeholder.dart';
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
      SearchMoviesInitialState() => const SearchInitialPlaceholder(),
      SearchMoviesLoading() => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
      SearchMoviesEmpty() => EmptyPlaceholder(
          icon: const _SearchEmptyIcon(),
          message: context.l10n.searchMoviesEmptyPhraseLabel,
        ),
      SearchMoviesError(:final apiError) => SliverFillRemaining(child: Text(apiError.getErrorMessage(context.l10n))),
      SearchMoviesSuccess(:final movies) => MoviesGridWidget(movies: movies),
    };
  }
}

class _SearchEmptyIcon extends StatelessWidget {
  const _SearchEmptyIcon();

  @override
  Widget build(BuildContext context) {
    return SvgImage(
      svgPath: AppAssets.icSearchEmpty,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.onBackground.withOpacity(.8),
        BlendMode.srcIn,
      ),
    );
  }
}
