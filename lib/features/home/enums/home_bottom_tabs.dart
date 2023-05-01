import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../support/extensions/context_extensions.dart';

enum HomeBottomTabs {
  dashboard,
  search,
  favorites,
  profile;

  IconData get icon {
    switch (this) {
      case HomeBottomTabs.dashboard:
        return FontAwesomeIcons.houseChimney;
      case HomeBottomTabs.search:
        return FontAwesomeIcons.magnifyingGlass;
      case HomeBottomTabs.favorites:
        return FontAwesomeIcons.solidHeart;
      case HomeBottomTabs.profile:
        return FontAwesomeIcons.solidUser;
    }
  }

  String getLabelText(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case HomeBottomTabs.dashboard:
        return l10n.bottomNavigationBarHomeLabel;
      case HomeBottomTabs.search:
        return l10n.bottomNavigationBarSearchLabel;
      case HomeBottomTabs.favorites:
        return l10n.bottomNavigationBarFavoritesLabel;
      case HomeBottomTabs.profile:
        return l10n.bottomNavigationBarProfileLabel;
    }
  }
}
