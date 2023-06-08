import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../models/movie.dart';
import '../utils/movie_db_image_path.dart';

class MovieCarouselCard extends StatelessWidget {
  final Movie movie;

  const MovieCarouselCard({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return ui.Gradient.linear(
                    Offset(0, bounds.height),
                    Offset.zero,
                    [Colors.transparent, Colors.black],
                  );
                },
                blendMode: BlendMode.darken,
                child: Image.network(
                  MovieDbImagePath.getImageUrl(
                    path: movie.backdropPath ?? '',
                    quality: ImageQuality.high,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.releaseDate?.year.toString() ?? '',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
