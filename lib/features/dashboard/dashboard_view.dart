import 'package:flutter/material.dart';

import '../../support/enums/movie_category.dart';
import 'movies_carousel/movies_carousel_view.dart';
import 'movies_horizontal_list/movies_horizontal_list_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                SafeArea(child: SizedBox(height: 16)),
                SizedBox(height: 16),
                MoviesCarouselView(movieCategory: MovieCategory.upcoming),
                SizedBox(height: 16),
                MoviesHorizontalListView(movieCategory: MovieCategory.nowPlaying),
                SizedBox(height: 16),
                MoviesHorizontalListView(movieCategory: MovieCategory.topRated),
                SizedBox(height: 16),
                MoviesHorizontalListView(movieCategory: MovieCategory.popular),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
