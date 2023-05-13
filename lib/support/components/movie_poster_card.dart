import 'package:flutter/material.dart';

import '../../models/movie.dart';
import '../utils/movie_db_image_path.dart';

class MoviePosterCard extends StatelessWidget {
  final Movie movie;

  const MoviePosterCard({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AspectRatio(
        aspectRatio: 2.2 / 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            MovieDbImagePath.getImageUrl(path: movie.posterPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
