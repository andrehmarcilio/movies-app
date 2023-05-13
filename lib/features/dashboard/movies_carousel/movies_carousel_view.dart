import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../../support/components/movie_carousel_card.dart';
import '../../../support/enums/movie_category.dart';
import '../../../support/extensions/context_extensions.dart';
import '../../../support/injector/app_injector.dart';
import 'cubit/movies_carousel_cubit.dart';
import 'cubit/movies_carousel_state.dart';

class MoviesCarouselView extends StatefulWidget {
  final MovieCategory movieCategory;

  const MoviesCarouselView({required this.movieCategory, super.key});

  @override
  State<MoviesCarouselView> createState() => _MoviesCarouselViewState();
}

class _MoviesCarouselViewState extends State<MoviesCarouselView> with AutomaticKeepAliveClientMixin {
  final cubit = AppInjector.get<MoviesCarouselCubit>();

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
          height: 240,
          child: ValueListenableBuilder(
            valueListenable: cubit,
            builder: _getMoviesCarouselByState,
          ),
        ),
      ],
    );
  }

  Widget _getMoviesCarouselByState(BuildContext context, MoviesCarouselState state, Widget? child) {
    return switch (state) {
      MoviesCarouselInitialState() || MoviesCarouselLoading() => const Center(child: CircularProgressIndicator()),
      MoviesCarouselError() => Text(state.apiError.getErrorMessage(context.l10n)),
      MoviesCarouselSuccess() => _MoviesCarousel(movies: state.movies),
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _MoviesCarousel extends StatelessWidget {
  final List<Movie> movies;

  const _MoviesCarousel({required this.movies});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      padEnds: false,
      controller: PageController(viewportFraction: 0.7),
      itemCount: movies.length,
      itemBuilder: (_, index) {
        final movie = movies[index];

        return MovieCarouselCard(movie: movie);
      },
    );
  }
}
