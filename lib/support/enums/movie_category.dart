import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum MovieCategory {
  popular('popular'),
  upcoming('upcoming'),
  topRated('top_rated'),
  nowPlaying('now_playing');

  final String path;

  const MovieCategory(this.path);

  String getSectionTitle(AppLocalizations l10n) {
    switch (this) {
      case MovieCategory.popular:
        return l10n.popularMoviesSectionTitle;
      case MovieCategory.upcoming:
        return l10n.upcomingMoviesSectionTitle;
      case MovieCategory.topRated:
        return l10n.topRatedMoviesSectionTitle;
      case MovieCategory.nowPlaying:
        return l10n.nowPlayingMoviesSectionTitle;
    }
  }
}
