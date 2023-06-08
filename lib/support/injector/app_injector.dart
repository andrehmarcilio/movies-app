import 'package:get_it/get_it.dart';

import '../../data/remote/routes/movies_routes.dart';
import '../../data/remote/setup/http_client.dart';
import '../../features/dashboard/movies_carousel/state/movies_carousel_view_model.dart';
import '../../features/dashboard/movies_horizontal_list/state/movies_horizontal_list_view_model.dart';
import '../../features/dashboard/use_cases/get_movies_use_case.dart';
import '../../features/search/state/search_movies_view_model.dart';
import '../../features/search/use_cases/search_movies_use_case.dart';

class AppInjector {
  static final _provider = GetIt.instance;

  static Type get<Type extends Object>() {
    return _provider.get<Type>();
  }

  static void initializeDependencies({bool testing = false}) {
    if (testing) {
      // TODO: Implements initializeDependencies when testing
      return;
    }

    // Common Singletons
    _provider.registerSingleton<HttpClient>(DioClient());

    _provider.registerSingleton<MoviesRoutes>(MoviesRoutesImpl(_provider.get<HttpClient>()));

    // Dashboard Feature
    _provider.registerFactory<GetMoviesUseCase>(() {
      return GetMoviesUseCaseImpl(moviesRoutes: _provider.get<MoviesRoutes>());
    });
    _provider.registerFactory<MoviesHorizontalListViewModel>(() {
      return MoviesHorizontalListViewModel(getMoviesUseCase: _provider.get<GetMoviesUseCase>());
    });
    _provider.registerFactory<MoviesCarouselViewModel>(() {
      return MoviesCarouselViewModel(getMoviesUseCase: _provider.get<GetMoviesUseCase>());
    });

    // Search Feature
    _provider.registerFactory<SearchMoviesUseCase>(() {
      return SearchMoviesUseCaseImpl(moviesRoutes: _provider.get<MoviesRoutes>());
    });
    _provider.registerFactory<SearchMoviesViewModel>(() {
      return SearchMoviesViewModel(searchMoviesUseCase: _provider.get<SearchMoviesUseCase>());
    });
  }
}
