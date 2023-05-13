import 'package:get_it/get_it.dart';

import '../../data/remote/routes/movies_routes.dart';
import '../../data/remote/setup/http_client.dart';
import '../../features/dashboard/movies_carousel/cubit/movies_carousel_cubit.dart';
import '../../features/dashboard/movies_horizontal_list/cubit/movies_horizontal_list_cubit.dart';
import '../../features/dashboard/use_cases/get_movies_use_case.dart';

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
    _provider.registerSingleton<MoviesRoutes>(MoviesRoutesImpl(get<HttpClient>()));

    // Dashboard Feature
    _provider.registerFactory<GetMoviesUseCase>(() {
      return GetMoviesUseCaseImpl(moviesRoutes: get<MoviesRoutes>());
    });
    _provider.registerFactory<MoviesHorizontalListCubit>(() {
      return MoviesHorizontalListCubit(getMoviesUseCase: get<GetMoviesUseCase>());
    });
    _provider.registerFactory<MoviesCarouselCubit>(() {
      return MoviesCarouselCubit(getMoviesUseCase: get<GetMoviesUseCase>());
    });
  }
}
