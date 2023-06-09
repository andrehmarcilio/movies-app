import 'package:flutter/material.dart';

import '../../../support/components/svg_image.dart';
import '../../../support/extensions/context_extensions.dart';
import '../../../support/style/app_assets.dart';

class SearchInitialPlaceholder extends StatelessWidget {
  const SearchInitialPlaceholder({super.key});

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
