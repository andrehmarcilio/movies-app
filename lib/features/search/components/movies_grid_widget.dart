import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../../support/components/movie_poster_card.dart';

class MoviesGridWidget extends StatelessWidget {
  final List<Movie> movies;

  const MoviesGridWidget({required this.movies, super.key});

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
